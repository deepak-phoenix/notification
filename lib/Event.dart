class Event {
  // Properties
  String _name;
  bool _isBirthday;
  bool _isAnniversary;
  DateTime _eventDate;

// constructor
  Event(this._name, this._eventDate, this._isAnniversary, this._isBirthday);

// Set methods
  void setName(String name) => this._name = name;

  void setIsBirthday(bool isBirthday) => this._isBirthday = isBirthday;

  void setIsAnniversary(bool isAnniversary) =>
      this._isAnniversary = isAnniversary;

  void setEventDate(DateTime eventDate) => this._eventDate = eventDate;

  // Get methods
  String getName() => this._name;
  bool getIsBirthday() => this._isBirthday;
  bool getIsAnniversary() => this._isAnniversary;
  DateTime getEvenDate() => this._eventDate;
}
