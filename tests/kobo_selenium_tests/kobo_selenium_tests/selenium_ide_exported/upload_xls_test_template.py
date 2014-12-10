# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class UploadXlsTestTemplate(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://kf.kbtdev.org/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_upload_xls_test_template(self):
        driver = self.driver
        driver.get(self.base_url + "")
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".forms-header__title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertFalse(self.is_element_present(By.CSS_SELECTOR, ".forms__card"))
        self.assertTrue(self.is_element_present(By.CSS_SELECTOR, ".forms-empty__button"))
        driver.find_element_by_css_selector(".forms-empty__button").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".forms__addform__drop--bottom-centered .forms__addform__xls input"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        # WARNING: The following command exports to Python as two commands, a 'clear' (undesired) and a 'send_keys' (desired). Manually edit the export.
        driver.find_element_by_css_selector(".forms__addform__drop--bottom-centered .forms__addform__xls input").clear()
        driver.find_element_by_css_selector(".forms__addform__drop--bottom-centered .forms__addform__xls input").send_keys("/tmp/Selenium_test_form_title.xls")
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".form-title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertEqual("Selenium test form title.", driver.find_element_by_css_selector(".form-title").text)
        self.assertEqual("Selenium test question label.", driver.find_element_by_css_selector(".card__header-title").text)
        self.assertEqual("Selenium test question choice 1.", driver.find_element_by_css_selector(".card--selectquestion__expansion li:nth-child(1) span").text)
        self.assertEqual("Selenium test question choice 2.", driver.find_element_by_css_selector(".card--selectquestion__expansion li:nth-child(2) span").text)
        self.assertTrue(self.is_element_present(By.ID, "save"))
        driver.find_element_by_id("save").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".forms__card__title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertEqual("Selenium test form title.", driver.find_element_by_css_selector(".forms__card__title").text)
    
    def is_element_present(self, how, what):
        try: self.driver.find_element(by=how, value=what)
        except NoSuchElementException, e: return False
        return True
    
    def is_alert_present(self):
        try: self.driver.switch_to_alert()
        except NoAlertPresentException, e: return False
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
