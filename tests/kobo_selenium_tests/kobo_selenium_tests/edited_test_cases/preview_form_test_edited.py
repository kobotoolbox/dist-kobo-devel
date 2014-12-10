# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class PreviewFormTestTemplate(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://kf.kbtdev.org/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_preview_form_test_template(self):
        driver = self.driver
        driver.get(self.base_url + "")
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".forms-header__title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".forms__card__title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".forms__card__title").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".form-title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertTrue(self.is_element_present(By.ID, "xlf-preview"))
        driver.find_element_by_id("xlf-preview").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".enketo-holder iframe"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        # Interactions/assertions within the Enketo preview 'iframe'.
        # WARNING: The 'selectFrame' command doesn't export to python, so a manual edit is necessary.
        driver.switch_to.frame(driver.find_element_by_css_selector(".enketo-holder iframe"))
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".preview #form-title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertEqual("Selenium test form title.", driver.find_element_by_css_selector(".preview #form-title").text)
        self.assertEqual("Selenium test question label.", driver.find_element_by_css_selector(".preview .question-label").text)
        self.assertEqual("Selenium test question choice 1.", driver.find_element_by_css_selector(".preview .question label:nth-child(1) .option-label").text)
        self.assertEqual("Selenium test question choice 2.", driver.find_element_by_css_selector(".preview .question label:nth-child(2) .option-label").text)
        driver.find_element_by_css_selector(".preview .question label:nth-child(1)").click()
        self.assertTrue(self.is_element_present(By.CSS_SELECTOR, ".preview #validate-form"))
        driver.find_element_by_css_selector(".preview #validate-form").click()
        # Wait for validation to complete (validation button progress bar will disappear).
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".preview #validate-form i"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        # Ensure that no validation warning was reported.
        self.assertEqual("", driver.find_element_by_css_selector("#dialog-alert .modal-header h3").text)
        # Switch back out of the Enketo 'iframe'
        # WARNING: The 'selectWindow' command doesn't export to python, so a manual edit is necessary.
        driver.switch_to.default_content()
        self.assertTrue(self.is_element_present(By.CSS_SELECTOR, ".enketo-holder .enketo-iframe-icon"))
        driver.find_element_by_css_selector(".enketo-holder .enketo-iframe-icon").click()
        self.assertFalse(self.is_element_present(By.CSS_SELECTOR, ".enketo-holder"))
        self.assertTrue(self.is_element_present(By.ID, "save"))
        driver.find_element_by_id("save").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".forms__card__title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
    
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
