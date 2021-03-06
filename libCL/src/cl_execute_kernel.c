/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   cl_execute_kernel.c                                :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: vkozlov <vkozlov@student.42.fr>            +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2018/02/07 20:56:00 by vkozlov           #+#    #+#             */
/*   Updated: 2018/03/18 15:47:31 by vkozlov          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "my_cl.h"

void		cl_exec_kernel(t_cl *cl, cl_uint size_wd,
						const size_t *val)
{
	cl_uint		work_dim;
	size_t		*global_work_size;
	cl_uint		i;
	cl_int		res;

	i = 0;
	work_dim = size_wd;
	global_work_size = (size_t*)malloc(sizeof(size_t) * size_wd);
	while (i < size_wd)
	{
		global_work_size[i] = val[i];
		i++;
	}
	res = clEnqueueNDRangeKernel(cl->commands, cl->kernel, work_dim, NULL,
								global_work_size, NULL, 0, 0, &cl->e);
	if (res != CL_SUCCESS)
	{
		ft_printf("Error while executing the kernel. Code:[%d]\n", res);
		exit(1);
	}
	clWaitForEvents(1, &cl->e);
	clFinish(cl->commands);
	free(global_work_size);
}
