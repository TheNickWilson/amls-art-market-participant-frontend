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

package utils

import java.time.format.DateTimeFormatter

import controllers.routes
import models.{CheckMode, UserAnswers}
import pages._
import play.api.i18n.Messages
import play.twirl.api.{Html, HtmlFormat}
import viewmodels.AnswerRow
import CheckYourAnswersHelper._

class CheckYourAnswersHelper(userAnswers: UserAnswers)(implicit messages: Messages) {

  def percentageTurnoverFromArt: Option[AnswerRow] = userAnswers.get(PercentageTurnoverFromArtPage) map {
    x =>
      AnswerRow(
        HtmlFormat.escape(messages("percentageTurnoverFromArt.checkYourAnswersLabel")),
        HtmlFormat.escape(messages(s"percentageTurnoverFromArt.$x")),
        routes.PercentageTurnoverFromArtController.onPageLoad(CheckMode).url
      )
  }

  def identifyLinkedTransactions: Option[AnswerRow] = userAnswers.get(IdentifyLinkedTransactionsPage) map {
    x =>
      AnswerRow(
        HtmlFormat.escape(messages("identifyLinkedTransactions.checkYourAnswersLabel")),
        yesOrNo(x),
        routes.IdentifyLinkedTransactionsController.onPageLoad(CheckMode).url
      )
  }

  def dateSoldOverThreshold: Option[AnswerRow] = userAnswers.get(DateSoldOverThresholdPage) map {
    x =>
      AnswerRow(
        HtmlFormat.escape(messages("dateSoldOverThreshold.checkYourAnswersLabel")),
        HtmlFormat.escape(x.format(dateFormatter)),
        routes.DateSoldOverThresholdController.onPageLoad(CheckMode).url
      )
  }

  def artSoldOverThreshold: Option[AnswerRow] = userAnswers.get(ArtSoldOverThresholdPage) map {
    x =>
      AnswerRow(
        HtmlFormat.escape(messages("artSoldOverThreshold.checkYourAnswersLabel")),
        yesOrNo(x),
        routes.ArtSoldOverThresholdController.onPageLoad(CheckMode).url
      )
  }

  def typeOfParticipant: Option[AnswerRow] = userAnswers.get(TypeOfParticipantPage) map {
    x =>
      AnswerRow(
        HtmlFormat.escape(messages("typeOfParticipant.checkYourAnswersLabel")),
        Html(x.map(value => HtmlFormat.escape(messages(s"typeOfParticipant.$value")).toString).mkString(",<br>")),
        routes.TypeOfParticipantController.onPageLoad(CheckMode).url
      )
  }

  private def yesOrNo(answer: Boolean)(implicit messages: Messages): Html =
    if (answer) {
      HtmlFormat.escape(messages("site.yes"))
    } else {
      HtmlFormat.escape(messages("site.no"))
    }
}

object CheckYourAnswersHelper {

  private val dateFormatter = DateTimeFormatter.ofPattern("d MMMM yyyy")
}
