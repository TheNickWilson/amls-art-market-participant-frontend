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

package models

import viewmodels.RadioOption

sealed trait PercentageTurnoverFromArt

object PercentageTurnoverFromArt extends Enumerable.Implicits {

  case object ZeroToTwenty extends WithName("zeroToTwenty") with PercentageTurnoverFromArt
  case object TwentyOnetoForty extends WithName("twentyOneToForty") with PercentageTurnoverFromArt
  case object FortyOneToSixty extends WithName("fortyOneToSixty") with PercentageTurnoverFromArt
  case object SixtyOneToEighty extends WithName("sixtyOneToEighty") with PercentageTurnoverFromArt
  case object EightyOneToOneHundred extends WithName("eightyOneToOneHundred") with PercentageTurnoverFromArt

  val values: Seq[PercentageTurnoverFromArt] = Seq(
    ZeroToTwenty, TwentyOnetoForty, FortyOneToSixty, SixtyOneToEighty, EightyOneToOneHundred
  )

  val options: Seq[RadioOption] = values.map {
    value =>
      RadioOption("percentageTurnoverFromArt", value.toString)
  }

  implicit val enumerable: Enumerable[PercentageTurnoverFromArt] =
    Enumerable(values.map(v => v.toString -> v): _*)
}
