module Errors
  class WizvilleError  < StandardError
      attr_accessor :code
      def initialize(message=nil, code=nil)
        super(message)
        self.code = code
      end
  end
  
  class NoActivityError < WizvilleError;  end

  class NoMicrophoneError < WizvilleError;  end

  class NoStudentFoundError < WizvilleError;  end
end