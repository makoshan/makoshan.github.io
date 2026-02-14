import argparse
import functools
import http.server
import os
import socketserver
import urllib.parse


def main() -> None:
    parser = argparse.ArgumentParser(
        description=(
            "Static file server for this repo.\n\n"
            "Unlike `python -m http.server`, this server treats extensionless HTML "
            "files (like `_site/About`) as `text/html` so browsers render them "
            "instead of downloading them."
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument("--bind", default="", help="Bind address (default: all interfaces)")
    parser.add_argument("--port", type=int, default=3001, help="Port to listen on (default: 3001)")
    parser.add_argument(
        "--directory",
        default=os.getcwd(),
        help="Directory to serve (default: current directory)",
    )
    args = parser.parse_args()

    directory = os.path.abspath(args.directory)
    base_cls = http.server.SimpleHTTPRequestHandler

    class Handler(base_cls):
        # Rewrite a few gwern.net-specific URL patterns for local preview:
        # - treat `/Foo.html` as `/Foo` when only extensionless output exists
        # - collapse accidental double `.html.html`
        def guess_type(self, path: str) -> str:
            # Force extensionless outputs (Hakyll routes like `/About`) to render as HTML.
            _, ext = os.path.splitext(path)
            if ext == "":
                return "text/html; charset=utf-8"
            return super().guess_type(path)

        def _rewrite_path(self) -> None:
            split = urllib.parse.urlsplit(self.path)
            path = split.path

            if path.endswith(".html.html"):
                path = path[:-5]

            if path.endswith(".html"):
                no_ext = path[:-5]
                fs_no_ext = self.translate_path(no_ext)
                fs_html = self.translate_path(path)
                if (not os.path.exists(fs_html)) and os.path.exists(fs_no_ext):
                    path = no_ext

            if path != split.path:
                self.path = urllib.parse.urlunsplit((split.scheme, split.netloc, path, split.query, split.fragment))

        def do_GET(self) -> None:
            self._rewrite_path()
            super().do_GET()

        def do_HEAD(self) -> None:
            self._rewrite_path()
            super().do_HEAD()

    # Ensure extensionless outputs (our Hakyll routes use no extension) are served as HTML.
    Handler.extensions_map = {
        **Handler.extensions_map,
        ".manifest": "text/cache-manifest",
        ".html": "text/html; charset=utf-8",
        ".htm": "text/html; charset=utf-8",
        ".css": "text/css; charset=utf-8",
        ".js": "text/javascript; charset=utf-8",
        ".svg": "image/svg+xml",
        ".page": "text/markdown; charset=utf-8",
        "": "text/html; charset=utf-8",
    }

    # Python 3.7+ supports `directory=` on the handler.
    handler = functools.partial(Handler, directory=directory)

    # Threading server avoids a hung connection blocking all others.
    with socketserver.ThreadingTCPServer((args.bind, args.port), handler) as httpd:
        bind = args.bind or "0.0.0.0"
        print(f"Serving {directory} on http://{bind}:{args.port}/")
        httpd.serve_forever()


if __name__ == "__main__":
    main()
