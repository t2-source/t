import asyncio
from playwright.async_api import async_playwright

async def main():
    url = "http://localhost:8000/indexnix.html"

    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await browser.new_page()

        # Listener log
        page.on("console", lambda msg: print("[console]", msg.text))
        page.on("pageerror", lambda err: print("[pageerror]", err))
        page.on("crash", lambda: print("[crash] Page crashed"))

        print(f"[*] Membuka {url}")
        await page.goto(url, wait_until="domcontentloaded")

        # biar proses tetap hidup, nangkep log
        await asyncio.sleep(9999999999999999)

asyncio.run(main())
