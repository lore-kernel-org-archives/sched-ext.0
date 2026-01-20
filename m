Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B51B366565
	for <sched-ext@lists.linux.dev>; Tue, 20 Jan 2026 18:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933229; cv=none; b=HMoAbCt8RK1wnVAo9wpRuPx3eKpddeFckhY8FzN+0DGNMg6S+A4gIfV+XFOvNuwtjMVVtKYUJckWg8Mpm5L83JNT8ZKCSjydslORoy3kxZenZbu0zKc/oJOo7zh+cYyAhiVYrpF+s4dFZjyu7Ei0zS3Ko+dp0Vohv0QjF7loKuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933229; c=relaxed/simple;
	bh=Id4cOmNEiQlVyYt3ZOmFEsW5EXk1o6WCVdlGjBzHwko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TGMMhNNkjtJANgD6QmgSxbLTPFGBE/5NddQBxlKZivmXjE22wx5FAJkjoatbW/mIrZz0EWK467NzQP5zZ1osjmcw9q8f+7CbIR8YVVEpnPEsJp+2j++xLe8qJTehQpw57ZWPwqNHH8sbgO21tOY/HSfq9L6WxJdboFkgeO9bKHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DSBWMH9t; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DSBWMH9t"
Message-ID: <4cb38afd-e795-44d5-b71e-e28ef46a713e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768933224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hw/sMcabrZCvewEQTdeG4CPdU3m3zhufQ69bpx+RQH4=;
	b=DSBWMH9t9DBoDy90DWa0S5Md9TPpZcYKg++8SBupfJ89+tSsHRDanBO0HYYftlmIQO5Gei
	JcFI5blTl0snagOQnbMXl0q24eJjmyBAHS22UMmB/CHSvr9uMKFcnKZzcAzq8cUs6UGtED
	F/leoiDdQNu3gIorPa2p5GwZuDNcc64=
Date: Tue, 20 Jan 2026 10:20:17 -0800
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 11/13] selftests/bpf: Migrate struct_ops_assoc
 test to KF_IMPLICIT_ARGS
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Mykyta Yatsenko <yatsenko@meta.com>, Tejun Heo <tj@kernel.org>,
 Alan Maguire <alan.maguire@oracle.com>,
 Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina <jikos@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
 sched-ext@lists.linux.dev
References: <20260116201700.864797-1-ihor.solodrai@linux.dev>
 <20260116201700.864797-12-ihor.solodrai@linux.dev>
 <b5fef9672be4395b76619b8bd39697bf28b93350.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <b5fef9672be4395b76619b8bd39697bf28b93350.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/19/26 5:59 PM, Eduard Zingerman wrote:
> On Fri, 2026-01-16 at 12:16 -0800, Ihor Solodrai wrote:
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> index 2357a0340ffe..225ea30c4e3d 100644
>> --- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> +++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
>> @@ -161,7 +161,9 @@ void bpf_kfunc_rcu_task_test(struct task_struct *ptr) __ksym;
>>  struct task_struct *bpf_kfunc_ret_rcu_test(void) __ksym;
>>  int *bpf_kfunc_ret_rcu_test_nostruct(int rdonly_buf_size) __ksym;
>>  
>> -int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __ksym;
>> -int bpf_kfunc_multi_st_ops_test_1_impl(struct st_ops_args *args, void *aux__prog) __ksym;
>> +#ifndef __KERNEL__
>> +extern int bpf_kfunc_multi_st_ops_test_1(struct st_ops_args *args, u32 id) __weak __ksym;
>> +extern int bpf_kfunc_multi_st_ops_test_1_assoc(struct st_ops_args *args) __weak __ksym;
>> +#endif
> 
> Nit: wbpf_kfunc_multi_st_ops_test_1 change is not necessary, right?

Right, but it felt wrong to only change one of these decls.

This header is weird in that it is included both in the module code
and in BPF progs, although it is typically not a problem since the
most kfunc signatures match.

Maybe it should have #ifndef __KERNEL__ followed by kfunc declarations
that correspond to vmlinux.h format? I haven't tried that, but seems
logical to me.

