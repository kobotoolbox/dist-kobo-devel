# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class EnterDataTest(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://kc.kbtdev.org/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_enter_data(self):
        driver = self.driver
        driver.get(self.base_url + "")
        self.assertTrue(self.is_element_present(By.LINK_TEXT, "Selenium test form title."))
        driver.find_element_by_link_text("Selenium test form title.").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".dashboard__button-enter-data"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".dashboard__button-enter-data").click()
        for i in range(60):
            try:
                if self.is_element_present(By.ID, "form-title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertEqual("Selenium test form title.", driver.find_element_by_css_selector("#form-title").text)
        self.assertEqual("Selenium test question label.", driver.find_element_by_css_selector(".question-label").text)
        self.assertEqual("Selenium test question choice 1.", driver.find_element_by_css_selector(".question label:nth-child(1) .option-label").text)
        self.assertEqual("Selenium test question choice 2.", driver.find_element_by_css_selector(".question label:nth-child(2) .option-label").text)
        driver.find_element_by_css_selector(".question label:nth-child(1)").click()
        self.assertTrue(self.is_element_present(By.ID, "submit-form"))
        driver.find_element_by_id("submit-form").click()
        # Ensure that the data was submitted and no alerts were generated.
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, "#feedback-bar p"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        for i in range(60):
            try:
                if not self.is_element_present(By.CSS_SELECTOR, "#feedback-bar p"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertEqual("", driver.find_element_by_css_selector("#dialog-alert .modal-header h3").text)
        for i in range(60):
            try:
                if "0" == driver.find_element_by_css_selector(".queue-length").text: break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.get(self.base_url + "selenium_test/forms/Selenium_test_form_title")
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".dashboard__submissions .dashboard__group-label"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertEqual("Submissions (1)", driver.find_element_by_css_selector(".dashboard__submissions .dashboard__group-label").text)
    
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
