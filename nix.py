import asyncio
from playwright.async_api import async_playwright
import os
import http.server
import socketserver
import threading

PORT = 8000

def run_server():
    handler = http.server.SimpleHTTPRequestHandler
    with socketserver.TCPServer(("", PORT), handler) as httpd:
        print(f"[*] Serving at http://localhost:{PORT}")
        httpd.serve_forever()

async def main():
    # start server di thread terpisah
    server_thread = threading.Thread(target=run_server, daemon=True)
    server_thread.start()

    async with async_playwright() as p:
        browser = await p.chromium.launch(
            headless=True,
            args=["--no-sandbox", "--disable-setuid-sandbox", "--disable-dev-shm-usage"]
        )
        page = await browser.new_page()
        page.on("console", lambda msg: print("Console:", msg.text))
        page.on("pageerror", lambda exc: print("PageError:", exc))

        url = f"http://localhost:{PORT}/indexnix.html"
        print(f"[*] Membuka {url}")

        await asyncio.sleep(1)  # tunggu server siap
        await page.goto(url, wait_until="domcontentloaded")

        await asyncio.Future()  # biar gak langsung exit

asyncio.run(main())
