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

package generators

import org.scalacheck.Arbitrary
import pages._

trait PageGenerators {

  implicit lazy val arbitraryPercentageTurnoverFromArtPage: Arbitrary[PercentageTurnoverFromArtPage.type] =
    Arbitrary(PercentageTurnoverFromArtPage)

  implicit lazy val arbitraryIdentifyLinkedTransactionsPage: Arbitrary[IdentifyLinkedTransactionsPage.type] =
    Arbitrary(IdentifyLinkedTransactionsPage)

  implicit lazy val arbitraryDateSoldOverThresholdPage: Arbitrary[DateSoldOverThresholdPage.type] =
    Arbitrary(DateSoldOverThresholdPage)

  implicit lazy val arbitraryArtSoldOverThresholdPage: Arbitrary[ArtSoldOverThresholdPage.type] =
    Arbitrary(ArtSoldOverThresholdPage)

  implicit lazy val arbitraryTypeOfParticipantPage: Arbitrary[TypeOfParticipantPage.type] =
    Arbitrary(TypeOfParticipantPage)
}
