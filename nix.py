import asyncio
from playwright.async_api import async_playwright
import os

async def main():
    html_path = os.path.abspath("indexnix.html")
    url = "file://" + html_path

    async with async_playwright() as p:
        browser = await p.chromium.launch(
            headless=True,
            args=["--no-sandbox", "--disable-dev-shm-usage"]
        )
        page = await browser.new_page()

        # pasang listener console lebih awal
        page.on("console", lambda msg: print("Console:", msg.text))

        print(f"[*] Membuka {url}")
        await page.goto(url)

        # biar jalan terus tanpa close
        await asyncio.Future()  

        await browser.close()

asyncio.run(main())
