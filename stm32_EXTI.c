

static IRQn_Type exti_get_irq_num(USART_TypeDef* usart) {
   switch((uint32_t) usart) {
     case USART1_BASE: return USART1_IRQn;
     case USART2_BASE: return USART2_IRQn;
     case USART3_BASE: return USART3_IRQn;
     case UART4_BASE:  return UART4_IRQn;
     case UART5_BASE:  return UART5_IRQn;
     case USART6_BASE: return USART6_IRQn;
     case UART7_BASE:  return UART7_IRQn;
     default: return SysTick_IRQn;	/* -1 */
   }
}

int exti_config(USART_TypeDef* usart, USART_CLK_SRC src, uint32_t control[3], uint32_t baud, bool ie) {
if (ie) {
		NVIC_SetPriority(exti_get_irq_num(usart), 4);
		NVIC_EnableIRQ(exti_get_irq_num(usart));
	}
}


void EXTI0_IRQHandler(void){
}

void EXTI1_IRQHandler(void){
}

void EXTI2_IRQHandler(void){
}

void EXTI3_IRQHandler(void){
}

void EXTI4_IRQHandler(void){
}
