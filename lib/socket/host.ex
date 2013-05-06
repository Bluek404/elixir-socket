defrecord Socket.Host, [:name, :aliases, :type, :length, :list] do
  def for(host, family) do
    :inet.getaddrs(host, family)
  end

  def for!(host, family) do
    case :inet.getaddrs(host, family) do
      { :ok, addresses } ->
        addresses

      { :error, code } ->
        raise PosixError, code: code
    end
  end

  def by_address(address) do
    case :inet.gethostbyaddr(address) do
      { :ok, host } ->
        { :ok, set_elem host, 0, Socket.Host }

      error ->
        error
    end
  end

  def by_address!(address) do
    case :inet.gethostbyaddr(address) do
      { :ok, host } ->
        set_elem host, 0, Socket.Host

      { :error, code } ->
        raise PosixError, code: code
    end
  end

  def by_name(name) do
    case :inet.gethostbyname(name) do
      { :ok, host } ->
        { :ok, set_elem host, 0, Socket.Host }

      error ->
        error
    end
  end

  def by_name(name, family) do
    case :inet.gethostbyname(name, family) do
      { :ok, host } ->
        { :ok, set_elem host, 0, Socket.Host }

      error ->
        error
    end
  end

  def by_name!(name) do
    case :inet.gethostbyname(name) do
      { :ok, host } ->
        set_elem host, 0, Socket.Host

      { :error, code } ->
        raise PosixError, code: code
    end
  end

  def by_name!(name, family) do
    case :inet.gethostbyname(name, family) do
      { :ok, host } ->
        set_elem host, 0, Socket.Host

      { :error, code } ->
        raise PosixError, code: code
    end
  end

  def name do
    case :inet.gethostname do
      { :ok, name } ->
        name
    end
  end

  def interfaces do
    :inet.getifaddrs
  end

  def interfaces! do
    case :inet.getifaddrs do
      { :ok, ifs } ->
        ifs

      { :error, code } ->
        raise PosixError, code: code
    end
  end
end