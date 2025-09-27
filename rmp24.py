import asyncio
from playwright.async_api import async_playwright
import os

async def main():
    html_path = os.path.abspath("index24.html")
    url = "file://" + html_path

    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await browser.new_page()

        print(f"[*] Membuka {url}")
        await page.goto(url)
        await asyncio.sleep(9999999999999999999999999999)

        # ambil console log
        logs = await page.evaluate("() => console.log")
        # kalau mau lebih detail, attach listener
        page.on("console", lambda msg: print("Console:", msg.text))

        await browser.close()

asyncio.run(main())
