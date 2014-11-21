# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class CreateFormTestTemplate(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://kf.kbtdev.org/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_create_form_test_template(self):
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
                if self.is_element_present(By.CSS_SELECTOR, ".forms__addform__start"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        # Click the form creation button using JavaScript to avoid element not visible errors.
        # WARNING: The 'runScript' command doesn't export to python, so a manual edit is necessary.
        # ERROR: Caught exception [ERROR: Unsupported command [runScript | $(".forms__addform__start").click(); | ]]
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".form-title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".form-title").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".survey-header__title input"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".survey-header__title input").send_keys(Keys.SHIFT, Keys.END, Keys.SHIFT, Keys.DELETE)
        driver.find_element_by_css_selector(".survey-header__title input").send_keys("Selenium test form title.", Keys.ENTER)
        self.assertEqual("Selenium test form title.", driver.find_element_by_css_selector(".form-title").text)
        self.assertTrue(self.is_element_present(By.CSS_SELECTOR, ".survey-editor .fa-plus"))
        driver.find_element_by_css_selector(".survey-editor .fa-plus").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".row__questiontypes__form > input"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".row__questiontypes__form > input").send_keys("Selenium test question label.", Keys.TAB)
        self.assertTrue(self.is_element_present(By.CSS_SELECTOR, ".row__questiontypes__form > button"))
        driver.find_element_by_css_selector(".row__questiontypes__form > button").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".questiontypelist__item[data-menu-item=\"select_one\"]"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".questiontypelist__item[data-menu-item=\"select_one\"]").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".card--selectquestion__expansion li:nth-child(1) span"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        self.assertEqual("Selenium test question label.", driver.find_element_by_css_selector(".card__header-title").text)
        driver.find_element_by_css_selector(".card--selectquestion__expansion li:nth-child(1) .editable-wrapper span:first-child").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".card--selectquestion__expansion li:nth-child(1) input"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".card--selectquestion__expansion li:nth-child(1) input").send_keys(Keys.SHIFT, Keys.END, Keys.SHIFT, Keys.DELETE)
        driver.find_element_by_css_selector(".card--selectquestion__expansion li:nth-child(1) input").send_keys("Selenium test question choice 1.", Keys.ENTER)
        self.assertEqual("Selenium test question choice 1.", driver.find_element_by_css_selector(".card--selectquestion__expansion li:nth-child(1) span").text)
        self.assertTrue(self.is_element_present(By.CSS_SELECTOR, ".card--selectquestion__expansion li:nth-child(2) span"))
        driver.find_element_by_css_selector(".card--selectquestion__expansion li:nth-child(2) span").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".card--selectquestion__expansion li:nth-child(2) input"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".card--selectquestion__expansion li:nth-child(2) input").send_keys(Keys.SHIFT, Keys.END, Keys.SHIFT, Keys.DELETE)
        driver.find_element_by_css_selector(".card--selectquestion__expansion li:nth-child(2) input").send_keys("Selenium test question choice 2.", Keys.ENTER)
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
