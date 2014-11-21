# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class InitialLoginTestTemplate(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://kf.kbtdev.org/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_initial_login_test_template(self):
        driver = self.driver
        driver.get(self.base_url + "accounts/login/?next=/")
        for i in range(60):
            try:
                if self.is_element_present(By.ID, "id_username"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_id("id_username").clear()
        driver.find_element_by_id("id_username").send_keys("selenium_test")
        self.assertTrue(self.is_element_present(By.ID, "id_password"))
        driver.find_element_by_id("id_password").clear()
        driver.find_element_by_id("id_password").send_keys("selenium_test")
        self.assertTrue(self.is_element_present(By.CSS_SELECTOR, ".registration__action"))
        driver.find_element_by_css_selector(".registration__action").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".forms-header__title"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        # WARNING: The 'runScript' command doesn't export to python, so a manual edit is necessary.
        # ERROR: Caught exception [ERROR: Unsupported command [runScript | window.trackJs.configure({ userId: "selenium" }) | ]]
        self.assertFalse(self.is_element_present(By.CSS_SELECTOR, ".forms__card"))
    
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
