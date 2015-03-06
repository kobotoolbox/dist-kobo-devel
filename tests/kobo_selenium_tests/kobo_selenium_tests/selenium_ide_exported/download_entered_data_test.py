# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class DownloadEnteredDataTest(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://kc.kbtdev.org/"
        self.verificationErrors = []
        self.accept_next_alert = True

    def test_download_entered_data(self):
        # Open KoBoCAT.
        driver = self.driver
        driver.get(self.base_url + "")

        # Assert that our form's title is in the list of projects and follow its link.
        self.assertTrue(self.is_element_present(By.LINK_TEXT, "Selenium test form title."))
        driver.find_element_by_link_text("Selenium test form title.").click()

        # Wait for and click the "Download data" link.
        for _ in xrange(self.DEFAULT_WAIT_SECONDS):
            self.check_timeout('Waiting for "Download data" link.')
            try:
                if self.is_element_present(By.LINK_TEXT, "Download data"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_link_text("Download data").click()

        # Wait for and click the "XLS" link.
        for _ in xrange(self.DEFAULT_WAIT_SECONDS):
            self.check_timeout('Waiting for "XLS" link.')
            try:
                if self.is_element_present(By.LINK_TEXT, "XLS"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_link_text("XLS").click()

        # Wait for the download page's header and ensure it contains the word "excel" (case insensitive).
        for _ in xrange(self.DEFAULT_WAIT_SECONDS):
            self.check_timeout('Waiting for download page\'s header.')
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".data-page__header"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertIsNotNone(re.compile('excel', re.IGNORECASE).search(driver.find_element_by_css_selector(".data-page__header").text))

        # Wait for the export progress status.
        for _ in xrange(self.DEFAULT_WAIT_SECONDS):
            self.check_timeout('Waiting for the export progress status.')
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".refresh-export-progress"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")

        # Wait (a little more than usual) for the export's download link and click it.
        for _ in xrange(30):
            self.check_timeout('Waiting for the export\'s download link.')
            try:
                if re.search(r"^Selenium_test_form_title_[\s\S]*$", driver.find_element_by_css_selector("#forms-table a").text): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector("#forms-table a").click()

    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException: return False
        return True

    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException: return False
        return True

    def close_alert_and_get_its_text(self):
        try:
            alert = self.driver.switch_to_alert()
            alert_text = alert.text
            if self.accept_next_alert:
                alert.accept()
            else:
                alert.dismiss()
            return alert_text
        finally: self.accept_next_alert = True

    def tearDown(self):
        self.driver.quit()
        self.assertEqual([], self.verificationErrors)

if __name__ == "__main__":
    unittest.main()
