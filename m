Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7423326F288
	for <sched-ext@lists.linux.dev>; Fri, 19 Jun 2026 15:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883126; cv=none; b=RttsYtygnw3z20rvAkU5CjRz+GyKCGUVMAlY8FQmYJMlJy2r5wgm1t5U2G43aM4xjveGVy7r3Qmrf+C5E3UztE5BS4NdA2Toq/2+VG8Gm4n4mkftmwl3k5E6wm3kJlRuvv/+Aj6RuXSU2OSWi3IcOdRJf5mF0KInvpPC+oJ7ris=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883126; c=relaxed/simple;
	bh=FLaGLy9wrbFD2CWC3yAzWNpWSP81kGzPR3khH+QRHy4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oxDYHtqNersZXi+AOWD6L+ULUD0HVIrFGMSYQXCEM+ol+c7WflvIDNPpZ1+yR+HrG/9q3t63O52E0+XGmMqPYCxeFN2P+eJF8qos2hhuYdwPB3zDSVfrxyR1AGvdRF7yfbzwy9Bei/4PxBGEKfPF0QZ0zeVPwgeT5vN0/5nXBfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=OCaFtIzS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="OCaFtIzS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 421682880;
	Fri, 19 Jun 2026 08:31:59 -0700 (PDT)
Received: from [10.1.27.69] (e127648.arm.com [10.1.27.69])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 291513F763;
	Fri, 19 Jun 2026 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781883123; bh=FLaGLy9wrbFD2CWC3yAzWNpWSP81kGzPR3khH+QRHy4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OCaFtIzS2kFxVfuRpzmVsw4nOK0pN1QWF/aI85xpGdt7YOHIXWqtFzpb8gkys7TNS
	 xUOXrI9Yg343LmL/2ZDRC29SP4qah+DgnPrY/jEiL9zNxwVm0c26ydYaMtqm0JaBsF
	 fTa0/VTq1j6F6ko8ll2IJb3fghx7UnFYZLQ0mrlA=
Message-ID: <1b75c8ce-19c1-4a35-8747-d63e28dbbc16@arm.com>
Date: Fri, 19 Jun 2026 16:31:59 +0100
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 0/2] sched_ext: Mark scx_bpf_cpu_rq() nullable
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Tejun Heo <tj@kernel.org>,
 David Vernet <void@manifault.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260619-f01-14-scx-cpu-rq-ret-null-v1-0-3b4281cdf0da@mails.tsinghua.edu.cn>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20260619-f01-14-scx-cpu-rq-ret-null-v1-0-3b4281cdf0da@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/19/26 15:45, Nuoqi Gui wrote:
> scx_bpf_cpu_rq() can return NULL for invalid CPU input or when no SCX
> scheduler is active, but its kfunc registration does not advertise the
> nullable return to the verifier.
> 
> Add KF_RET_NULL to scx_bpf_cpu_rq(), matching the nullable metadata already
> present on neighboring SCX accessors, and add a sched_ext selftest that rejects
> an unchecked direct runqueue field read.
> 

See 5c48d88fe004 ("sched_ext: deprecation warn for scx_bpf_cpu_rq()")
I guess I can send a patch to remove the function, it's been a while.

> This fixes a regression introduced by 6203ef73fa5c ("sched/ext: Add BPF
> function to fetch rq").

How so?

> 
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
> Nuoqi Gui (2):
>       sched_ext: Mark scx_bpf_cpu_rq() as nullable
>       selftests/sched_ext: Cover scx_bpf_cpu_rq() null return
> 
>  kernel/sched/ext.c                                 |  2 +-
>  tools/testing/selftests/sched_ext/Makefile         |  1 +
>  .../selftests/sched_ext/cpu_rq_ret_null.bpf.c      | 27 +++++++++++++++
>  .../testing/selftests/sched_ext/cpu_rq_ret_null.c  | 38 ++++++++++++++++++++++
>  4 files changed, 67 insertions(+), 1 deletion(-)
> ---
> base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
> change-id: 20260617-f01-14-scx-cpu-rq-ret-null-2e79535acd57
> 
> Best regards,
> --  
> Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> 
> 

