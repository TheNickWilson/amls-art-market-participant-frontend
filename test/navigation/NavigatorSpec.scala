/*
 * Copyright 2019 HM Revenue & Customs
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package navigation

import java.time.LocalDate

import base.SpecBase
import controllers.routes
import pages._
import models._
import org.scalatest.TryValues

class NavigatorSpec extends SpecBase with TryValues {

  val navigator = new Navigator

  "Navigator" when {

    "in Normal mode" must {

      "go to Index from a page that doesn't exist in the route map" in {

        case object UnknownPage extends Page
        navigator.nextPage(UnknownPage, NormalMode, UserAnswers("id")) mustBe routes.IndexController.onPageLoad()
      }

      "go from Type of Participant to Art Sold Over Threshold" in {

        val answers = UserAnswers("id")

        navigator.nextPage(TypeOfParticipantPage, NormalMode, answers)
          .mustBe(routes.ArtSoldOverThresholdController.onPageLoad(NormalMode))
      }

      "go from Art Sold Over Threshold to Date Sold Over Threshold when the user answers yes" in {

        val answers = UserAnswers("id").set(ArtSoldOverThresholdPage, true).success.value

        navigator.nextPage(ArtSoldOverThresholdPage, NormalMode, answers)
          .mustBe(routes.DateSoldOverThresholdController.onPageLoad(NormalMode))
      }

      "go from Art Sold Over Threshold to Identify Linked Transactions when the user answers no" in {

        val answers = UserAnswers("id").set(ArtSoldOverThresholdPage, false).success.value

        navigator.nextPage(ArtSoldOverThresholdPage, NormalMode, answers)
          .mustBe(routes.IdentifyLinkedTransactionsController.onPageLoad(NormalMode))
      }

      "go from Identify Linked Transactions to Percentage Turnover From Art" in {

        val answers = UserAnswers("id")

        navigator.nextPage(IdentifyLinkedTransactionsPage, NormalMode, answers)
          .mustBe(routes.PercentageTurnoverFromArtController.onPageLoad(NormalMode))
      }

      "go from Percentage Turnover From Art to Check Your Answers" in {

        val answers = UserAnswers("id")

        navigator.nextPage(PercentageTurnoverFromArtPage, NormalMode, answers)
          .mustBe(routes.CheckYourAnswersController.onPageLoad())
      }
    }

    "in Check mode" must {

      "go to CheckYourAnswers from a page that doesn't exist in the edit route map" in {

        case object UnknownPage extends Page
        navigator.nextPage(UnknownPage, CheckMode, UserAnswers("id")) mustBe routes.CheckYourAnswersController.onPageLoad()
      }

      "go from Art Sold Over Threshold to Date Sold Over Threshold when the user answers Yes and Date Sold Over Threshold has not been answered" in {

        val answers =
          UserAnswers("id")
            .set(ArtSoldOverThresholdPage, true).success.value

        navigator.nextPage(ArtSoldOverThresholdPage, CheckMode, answers)
          .mustBe(routes.DateSoldOverThresholdController.onPageLoad(CheckMode))
      }

      "go from Art Sold Over Threshold to Check Your Answers when the user answers Yes and Date Sold Over Threshold has already been answered" in {

        val answers =
          UserAnswers("id")
            .set(DateSoldOverThresholdPage, LocalDate.now()).success.value
            .set(ArtSoldOverThresholdPage, true).success.value

        navigator.nextPage(ArtSoldOverThresholdPage, CheckMode, answers)
          .mustBe(routes.CheckYourAnswersController.onPageLoad())
      }

      "go from Art Sold Over Threshold to Check Your Answers when the user answers No" in {

        val answers = UserAnswers("id").set(ArtSoldOverThresholdPage, false).success.value

        navigator.nextPage(ArtSoldOverThresholdPage, CheckMode, answers)
          .mustBe(routes.CheckYourAnswersController.onPageLoad())
      }
    }
  }
}
