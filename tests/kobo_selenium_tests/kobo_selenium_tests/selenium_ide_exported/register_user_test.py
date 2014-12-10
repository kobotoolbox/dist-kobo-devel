# -*- coding: utf-8 -*-
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import Select
from selenium.common.exceptions import NoSuchElementException
from selenium.common.exceptions import NoAlertPresentException
import unittest, time, re

class RegisterUserTest(unittest.TestCase):
    def setUp(self):
        self.driver = webdriver.Firefox()
        self.driver.implicitly_wait(30)
        self.base_url = "http://kf.kbtdev.org/"
        self.verificationErrors = []
        self.accept_next_alert = True
    
    def test_register_user(self):
        driver = self.driver
        driver.get(self.base_url + "/accounts/login/?next=/")
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".registration__footer a"): break
            except: pass
            time.sleep(1)
        else: self.fail("time out")
        driver.find_element_by_css_selector(".registration__footer a").click()
        self.assertTrue(self.is_element_present(By.ID, "id_username"))
        driver.find_element_by_id("id_username").clear()
        driver.find_element_by_id("id_username").send_keys("selenium")
        self.assertTrue(self.is_element_present(By.ID, "id_email"))
        driver.find_element_by_id("id_email").clear()
        driver.find_element_by_id("id_email").send_keys("selenium@kobotoolbox.org")
        self.assertTrue(self.is_element_present(By.ID, "id_password1"))
        driver.find_element_by_id("id_password1").clear()
        driver.find_element_by_id("id_password1").send_keys("selenium")
        self.assertTrue(self.is_element_present(By.ID, "id_password2"))
        driver.find_element_by_id("id_password2").clear()
        driver.find_element_by_id("id_password2").send_keys("selenium")
        self.assertTrue(self.is_element_present(By.CSS_SELECTOR, ".registration__action"))
        driver.find_element_by_css_selector(".registration__action").click()
        for i in range(60):
            try:
                if self.is_element_present(By.CSS_SELECTOR, ".registration__message--complete"): break
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
