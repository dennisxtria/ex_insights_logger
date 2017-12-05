defmodule LittleApp do
  require Logger

  def log_info do
    Logger.info "Just some random logging"
  end

  def log do
    Logger.log :error, "Test error"
    Logger.log :info, "Test info"
    Logger.log :warn, "Test warn"
  end

  def log_warn do
    Logger.warn fn -> {"expensive to calculate warning", [additional: "WarningMeta"]} end
  end

  def log_error do
    try do
      raise "oops"
    rescue
      e in RuntimeError -> Logger.error "This error occured: #{inspect e}"
    end
  end

  def log_in_out do
    Logger.debug("Functionality started!", [value: 15])
    :timer.sleep(5000)
    Logger.debug("Functionality ended!", [value: 100])
  end

  def log_functionality do
    #todo track dependancy
    Logger.debug("Functionality started!", [value: 15])
    :timer.sleep(5000)
    Logger.debug("Functionality ended!", [value: 100])
  end
  
end