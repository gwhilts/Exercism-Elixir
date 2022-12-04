defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601!(string)
  end

  def before_noon?(datetime) do
    :lt == Time.compare(datetime, ~T[12:00:00])
  end

  def return_date(checkout_datetime) do
    if before_noon?(checkout_datetime) do
      Date.add(checkout_datetime, 28)
    else
      Date.add(checkout_datetime, 29)
    end
  end

  def days_late(planned_return_date, actual_return_datetime) do
    Date.diff(actual_return_datetime, planned_return_date)
    |> max(0)
  end

  def monday?(datetime) do
    1 == Date.day_of_week(datetime)
  end

  def calculate_late_fee(checkout, return, rate) do
    due = datetime_from_string(checkout) |> return_date()
    actual = datetime_from_string(return)

    days_late(due, actual) * rate * monday_discount(actual) |> trunc()
  end

  defp monday_discount(date) do
    if monday?(date), do: 0.5, else: 1
  end
end
