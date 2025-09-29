import asyncio
from playwright.async_api import async_playwright
import os

async def main():
    html_path = os.path.abspath("index24.html")
    url = "http://localhost:8000/index24.html"

    async with async_playwright() as p:
        browser = await p.chromium.launch(
            headless=True,
            args=["--disable-gpu", "--no-sandbox"]
        )
        page = await browser.new_page()

        # Listener console log
        page.on("console", lambda msg: print("[Browser]", msg.text))

        print(f"[*] Membuka {url}")
        await page.goto(url, wait_until="load", timeout=60000)

        print("[*] Miner berjalan... tekan Ctrl+C untuk stop")

        # loop idle supaya Python tetap hidup
        try:
            while True:
                await asyncio.sleep(1)
        except KeyboardInterrupt:
            print("\n[*] Dihentikan oleh user")

        await browser.close()

asyncio.run(main())
