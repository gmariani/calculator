/*
 * Flash Calculator
 *
 * by Gabriel Mariani
 */
class cv_Calculator {
	///////////////
	// Variables //
	///////////////
	/* Public */
	public var display_arg:Number;
	/* Private */
	private var memory:Number;
	private var display_txt:TextField;
	private var m_icon_txt:TextField;
	private var equation_array:Array;
	private var input_lock:Boolean;
	private var compute_lock:Boolean;
	///////////////
	// Construct //
	///////////////
	// dsply:TextField = target display textfield
	// m:TextField     = target textfield to display memory icon
	//
	function cv_Calculator(dsply:TextField, m:TextField) {
		display_txt = dsply;
		m_icon_txt = m;
		display_arg = 0;
		compute_lock = true;
		equation_array = new Array();
	}
	///////////////////////////////////////////////////////////////////////////////////////////
	// PUBLIC                                                                                //
	///////////////////////////////////////////////////////////////////////////////////////////
	////////////////
	// Add Number //
	////////////////
	public function addNum(arg1:Number):Void {
		if (display_arg == 0) {
			display_arg = arg1;
		} else if (equation_array.length == 2 && input_lock == false) {
			display_arg = arg1;
			input_lock = true;
		} else {
			display_arg = (display_arg * 10) + arg1;
		}
		compute_lock = false;
		// Update Display
		display_txt.text = String(display_arg);
	}
	//////////////////
	// Add Operator //
	//////////////////
	public function addOperator(operator:String):Void {
		if (equation_array.length == 0) {
			// Add First Arg/Oper
			equation_array.push(display_arg);
			equation_array.push(operator);
			input_lock = false;
		} else if (equation_array.length == 2 && compute_lock == false) {
			// Add Second Arg/Compute
			// Compute lock makes sure the current display is after user input and not the class
			equation_array.push(display_arg);
			display_arg = computeEquation(equation_array[1], equation_array[0], equation_array[2]);
			equation_array = new Array();
			equation_array.push(display_arg);
			equation_array.push(operator);
			compute_lock = true;
			input_lock = false;
			// Update Display
			display_txt.text = String(display_arg);
		}
	}
	//////////////////
	// Memory Store //
	//////////////////
	public function memoryStore():Void {
		memory = display_arg;
		m_icon_txt.text = "M";
	}
	///////////////////
	// Memory Recall //
	///////////////////
	public function memoryRecall():Void {
		// Update Display
		display_txt.text = String(memory);
		display_arg = memory;
	}
	//////////////////
	// Memory Clear //
	//////////////////
	public function memoryClear():Void {
		memory = null;
		m_icon_txt.text = "";
	}
	////////////////
	// Memory Add //
	////////////////
	public function memoryAdd():Void {
		memory += Number(display_txt.text);
	}
	/////////////////
	// Square Root //
	/////////////////
	public function squareRoot():Void {
		display_arg = Math.sqrt(display_arg);
		// Update Display
		display_txt.text = String(display_arg);
	}
	/////////////
	// Percent //
	/////////////
	public function percent():Void {
		if (equation_array.length == 2) {
			display_arg = equation_array[0] * (display_arg / 100);
		} else {
			display_arg = 0;
		}
		// Update Display
		display_txt.text = String(display_arg);
	}
	////////////////
	// Reciprical //
	////////////////
	public function reciprical():Void {
		display_arg = 1 / display_arg;
		// Update Display
		display_txt.text = String(display_arg);
	}
	/////////////
	// Inverse //
	/////////////
	public function inverse():Void {
		display_arg *= -1;
		// Update Display
		display_txt.text = String(display_arg);
	}
	///////////////////
	// Clear Display //
	///////////////////
	public function clearDisplay():Void {
		display_arg = 0;
		// Update Display
		display_txt.text = String(display_arg);
	}
	///////////////////////
	// Clear Calculation //
	///////////////////////
	public function clearCalculation():Void {
		equation_array = new Array();
		display_arg = 0;
		display_txt.text = String(display_arg);
	}
	///////////////
	// Backspace //
	///////////////
	public function backspace():Void {
		// Compute lock makes sure the current display is after user input and not the class
		if (compute_lock == false) {
			if (display_arg < 0) {
				display_arg = Math.ceil(display_arg / 10);
			} else {
				display_arg = Math.floor(display_arg / 10);
			}
			// Update Display
			display_txt.text = String(display_arg);
		}
	}
	/////////////
	// Compute //
	/////////////
	public function computeEquation(operator:String, arg1:Number, arg2:Number):Number {
		var resultVar:Number;
		switch (operator) {
		case "add" :
			resultVar = addVars(arg1, arg2);
			break;
		case "subtract" :
			resultVar = subtractVars(arg1, arg2);
			break;
		case "multiply" :
			resultVar = multiplyVars(arg1, arg2);
			break;
		case "divide" :
			resultVar = divideVars(arg1, arg2);
			break;
		default :
			trace("It's broke yo");
		}
		return resultVar;
	}
	////////////
	// Equals //
	////////////
	public function equals() {
		if (equation_array.length == 2) {
			display_arg = computeEquation(equation_array[1], equation_array[0], display_arg);
		} else if (equation_array.length == 1) {
			display_arg = equation_array[0];
		}
		equation_array = new Array();
		// Update Display
		display_txt.text = String(display_arg);
	}
	///////////////////////////////////////////////////////////////////////////////////////////
	// PRIVATE                                                                               //
	///////////////////////////////////////////////////////////////////////////////////////////
	//////////////
	// Add Vars //
	//////////////
	private function addVars(arg1:Number, arg2:Number):Number {
		return arg1 + arg2;
	}
	///////////////////
	// Subtract Vars //
	///////////////////
	private function subtractVars(arg1:Number, arg2:Number):Number {
		return arg1 - arg2;
	}
	///////////////////
	// Multiply Vars //
	///////////////////
	private function multiplyVars(arg1:Number, arg2:Number):Number {
		return arg1 * arg2;
	}
	/////////////////
	// Divide Vars //
	/////////////////
	private function divideVars(arg1:Number, arg2:Number):Number {
		return arg1 / arg2;
	}
}
