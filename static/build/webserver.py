import sys

import http.server
from http.server import HTTPServer, BaseHTTPRequestHandler
import socketserver
PORT = 3001

Handler = http.server.SimpleHTTPRequestHandler

Handler.extensions_map={
    '.manifest': 'text/cache-manifest',
    '.html': 'text/html',
    '.png': 'image/png',
    '.jpg': 'image/jpg',
    '.svg': 'image/svg+xml',
    '.css': 'text/css',
    '.js':  'application/x-javascript',
    '.page': 'text/markdown',
    '': 'text/html' # Default
}

httpd = socketserver.TCPServer(("", PORT), Handler)
print("serving at port", PORT)
httpd.serve_forever()

