# The {datalark} package!

Akin to the mudlark searching for treasures on the foreshore, the datalark often finds themselves having to search through messy data sets before finding data treasures! Clean data is essential to maintain data integrity. Like the mudlark attempting to preserve their finds, the datalark must ensure that their data cleaning techniques preserve the original response. Improper cleaning of data can result in inaccurate or missing data.

When alpha-numeric responses are allowed in a response field such as number of hours worked, participants often give more than just a numeric estimate. Often, in their desire to be as accurate as possible, they will provide numeric ranges; use symbols such as “~”, “+”, or “<“; or will use words such as “approximate”. When this is not minimized through the restriction of response fields to numeric input only, it can require a lot of data cleaning. 

Much like the mudlark attempting to preserve their finds, the datalark must ensure that their data cleaning techniques preserve the original response. For example, if a participant were to give the numeric response “1-2 hours” to the question “How many minutes do you spend exercising in a week?”, then a function that takes the mean of 1 and 2 hours and returns “1.5” would be problematic, as the response was supposed to be in minutes. Thus, the data needs to be processed carefully, and this package aims to do so by offering numerous functions that work together to preserve the data, and also have safeguards in place to protect against inadvertent processing.

## Installation

To install the {datalark} package, use the {devtools} package to download directly this from GitHub repository:

```
devtools::install_github("kbelisar/datalark”)
```

## change_measures()

Participants sometimes give responses in a different unit of measurement than requested. The alternative unit of measurement may accompany their response, allowing for transformation into the proper unit of measurement. This function will transform common units of measurement found in participant data that are within a one-unit magnitude of one another. Specifically, months can be transformed into years or weeks, but cannot be transformed into minutes. This function will also transform the most common imperior versus metric measurements that are found in participant, namely weight and height. 

This function requires two arguments (`from` and `to`), and the table below shows which units of measurement can be transformed from or into:

| Unit 1      | &#8592; &#8594; |  Unit 2 |
|-------------|-----------------|---------|
| Years       | &#8592; &#8594; | Months  |
| Months      | &#8592; &#8594; | Weeks   |
| Weeks       | &#8592; &#8594; | Days    |
| Days        | &#8592; &#8594; | Hours   |
| Hours       | &#8592; &#8594; | Minutes |
| Kilograms   | &#8592; &#8594; | Pounds  |
| Grams       | &#8592; &#8594; | Ounces  |
| Centimeters | &#8592; &#8594; | Inches  |
          
## clean_measures()

Participants will sometimes provide the unit of measurement in their response for precision. Although well intentioned, this requires additional cleaning, and is complicated when symbols or other desciptive approximations are given such as "approx.","~","<", or "max". 

This function can clean the following units of measurement, which is selected using the `type` argument:

- Minutes
- Hours
- Days
- Weeks
- Months
- Years
- Grams
- Ounces
- Kilograms
- Pounds
- Centimetres
- Inches

This function will also clean the following symbols, if the argument `symbols` is set to TRUE: "<",">","~","+","?","??",

Setting the `symbols` argument to TRUE will also remove words relating to approximations which are often seen in participant responses when the text field is open-ended: "less than", "greater than", "minimum", "maximum", "approximately","around", "roughly".

## clean_money()

Similar to the `clean_measures()` function, this function is specifically for monetary amounts and will remove the symbols and related estimates that are common in responses to questions about earnings or money spent. This function can also transform values when a "k" is used to denote thousands when the argument 'transform' is set to TRUE.

## rangle_calc()

Participants, eager to be both detailed and precise in their resonses, will often give a range of values as an approximation. Although well-intentioned, this can be cumbersome to clean! This function carefully transforms ranges into the average between the two values given, whilst also preserving all non-range responses (including alpha-numeric responses). This is especially important given that there may be additional text-based responses given that either can be handled using the other functions in this package, or in the case of complicated responses, can be retained and handled manually.

## zero_measures()

When alpha-numeric responses are allowed, participants can sometimes write their response of 0 as "zero", "none", or "null". This function will transform these responses into the numeric response of 0. It will also transform responses written by participants as "NA" if the argument `include.na` is set to TRUE, whilst retaining true missing values. See the examples using the sample data below.

# Examples - Sample Data !!! NEEDS WORK IMPROVE EXAMPLES

This sample data ('dl_data') provided by this package is a mock-up of common response formats seen when responses are open-text/ allow alpha-numeric responses. The data are from 15 fictional participants and are as follows:

| Variable Name    | Description                    |
|------------------|--------------------------------|
| ID               | Unique participant identifier  |
| employment_hours | Average number of hours worked per week |
| household_income | Gross household income per year |
| minutes_exercised| Average number of hours spent engaged in moderate activity/ exercise per week |
| cann_endorsed    | Endorsement of cannabis use during the past month |
| cann_amount      | Amount of dried cannabis consumed on average per week in grams |

## Employment Hours

Examining the `employment_hours` variable, there are approximations present in the responses using both text and symbols. The `clean_measures` function can be used to clean these responses:

```
dl_data$employment_hours_2 <- clean_measures(dl_data$employment_hours, type = "hours", symbols = T)
```

As we can see in the original data, participant ID # 10 has additional pertinent information surrounding the fact that they work 2 jobs at 20 hours each. The `clean_measures` function identified that there was additional text in the given response, and retained the response in its entirety.

The variable also contains a lot of ranges that were given as responses, and would benefit from utilizing the `range_calc` function.
