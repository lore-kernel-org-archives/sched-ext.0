Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E7A2D541B
	for <sched-ext@lists.linux.dev>; Fri, 27 Mar 2026 01:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774574828; cv=none; b=ilInVnh5VojG8XGRwLAvznFyKFt/3NK+uJpxmayhXW1dVMkegTBZEtjuVGZmiLEzQYWgqeQ/IsnKMhsYPexYszP6cyvAC9DyBRaKybLs8WUY/77BpFOJAX1vy0oDihP6zkaEWS63Vww+EpdnFme+/k2bPUfGAu4g4fXj1ukDu0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774574828; c=relaxed/simple;
	bh=chXs2+hyKywTjFcuJlMemyJALAk6VGNXnAhjTkGKBlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XZ2NYjefMVikKlQDkU1IQ5ZsBOfjx25JJY0l+HTvit3lLIlpVMcIQyklV15XN7aNDBjJTonrJ/TBAkslGCW+Ie6S/Z0r4gvEHaJW7R2ajjyWZmzV9HmhctnzxWjTrCkULkD72O0AtRLAZF5rIWO5wlIfW7JOq4EVgSaBlIJXhT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=das1oYwy; arc=none smtp.client-ip=117.135.210.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="das1oYwy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=jAikSVF5ebVLeX6g4oSjgFGPIS6eC0FA6i51prQbOCE=;
	b=das1oYwyNUUQfZ1AxWFvzo1iD828+lIBA4YDiVzt6+cq7h8kBQmUoyvlqVhTie
	mQ+jLrfH5JTEFmtR19HvyqUbtaQrq2DtxcAlDy0bfPEXzXdDTrpHYo65AUBgInBr
	+ygSxGseTHGufWqfP7EPDtzUB6P/opDckg+sRyfxM2ZBw=
Received: from [198.18.0.1] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PykvCgDnL9PN3MVpAzWdCQ--.43197S2;
	Fri, 27 Mar 2026 09:26:38 +0800 (CST)
Message-ID: <8e12a520-353f-4a70-8b26-c4d76382d583@126.com>
Date: Fri, 27 Mar 2026 09:26:37 +0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/sched_ext: scx_central: start timer from central
 dispatch
To: Tejun Heo <tj@kernel.org>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
 emil@etsalapatis.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhaomengmeng@kylinos.cn
References: <20260326091523.299333-1-zhaomzhao@126.com>
 <acXWMnYJPD_uGf_l@slm.duckdns.org>
From: Zhao Mengmeng <zhaomzhao@126.com>
In-Reply-To: <acXWMnYJPD_uGf_l@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PykvCgDnL9PN3MVpAzWdCQ--.43197S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tr1UZr13trWftFW8ArWkWFg_yoW8CFyfpF
	9FkFWxGFs8trW3Aw42yw18Cry3Za1fXr17trn7GrnxJw4xur4UK34rJFya9FyDGr4kA34D
	Aayj9rZ5Gw4qv37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1VbkUUUUU=
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqg42rWnF3M4AtAAA31

On 3/27/26 08:58, Tejun Heo wrote:
> Hello, Zhao.
> 
> On Thu, Mar 26, 2026 at 05:15:23PM +0800, Zhao Mengmeng wrote:
>> From: Zhao Mengmeng <zhaomengmeng@kylinos.cn>
>>
>> scx_central currently assumes that ops.init() runs on the selected
>> central CPU and aborts otherwise. This is no longer true, as ops.init()
>> is invoked from the scx_enable_helper thread, which can run on any
>> CPU. As a result, sched_setaffinity() from userspace doesn't work, loading
>> scx_central can fail with:
>>
>> [ 1985.319942] sched_ext: central: scx_central.bpf.c:314: init from non-central CPU
>> [ 1985.320317]    scx_exit+0xa3/0xd0
>> [ 1985.320535]    scx_bpf_error_bstr+0xbd/0x220
>> [ 1985.320840]    bpf_prog_3a445a8163fa8149_central_init+0x103/0x1ba
>> [ 1985.321073]    bpf__sched_ext_ops_init+0x40/0xa8
>> [ 1985.321286]    scx_root_enable_workfn+0x507/0x1650
>> [ 1985.321461]    kthread_worker_fn+0x260/0x940
>> [ 1985.321745]    kthread+0x303/0x3e0
>> [ 1985.321901]    ret_from_fork+0x589/0x7d0
>> [ 1985.322065]    ret_from_fork_asm+0x1a/0x30
>>
>> DEBUG DUMP
>> ===================================================================
>>
>> central: root
>> scx_enable_help[134] triggered exit kind 1025:
>>   scx_bpf_error (scx_central.bpf.c:314: init from non-central CPU)
>>
>> To fix it, initialize the BPF timer from ops.init(), but defer
>> bpf_timer_start() to the first dispatch on the central CPU. This preserves
>> the requirement that the timer be started from the central CPU when
>> BPF_F_TIMER_CPU_PIN is used, without depending on the CPU affinity of
>> the enable path.
> 
> Can you do the followings please?
> 
> - Remove now unnecessary sched_setaffinity() call.
> 
> - Do scx_bpf_kick_cpu(central_cpu, 0) so that we're guaranteed to enter the
>   dispatch path on the central CPU immediately.
> 
> Thanks.
> 
No Problem. Will try it.

