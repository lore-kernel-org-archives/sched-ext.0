Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376BD39BFF4
	for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 12:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270421; cv=none; b=b515InLt1j3ivL5IGV+J74fdIt5lQXkQIzX4SQDDYf5E4Xa7IbA70UIHyxn6dBXOc70u/0Q9in634Hapu1hsKFNSZGybPVVceIDr197Fc2S6/8H0fc3QpFwmu6aJUJY47qfXxdbTtW/G+1pMcGAjmxNR3RhK1O3DwXbClTsFYoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270421; c=relaxed/simple;
	bh=xk04I0fYWeNC2tc4jGp044ue//lR7onBw75BnVrE2D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7Mkx0p8Hf4WGxVcbzRzuftgIyFnHEoHktVrshS/Df+g6GJpFjsfnCVjW9Zubpj4H65RMmSnT+df/yh9tvdisTxtmhmJ0Gtni0LIxbBus2RTAHCAIEarySa8re6E7PECmEC0FFE1Jnd0nCb4jGj5Lf46yckzq8+FcYFDn7k8wJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/eKledc; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/eKledc"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c73ba417c6eso34135a12.3
        for <sched-ext@lists.linux.dev>; Mon, 23 Mar 2026 05:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774270420; x=1774875220; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aB63dwJ3+/i55uxvUy7eEOFEjEhDnPyKdnJvMiRZ4Yk=;
        b=a/eKledcGKKhtG9mtmcJTrBMuf+iWfBr8J+SYIHPoPj4onE0vqJWOhiuHP23dplKSO
         E/5XNZq9UjLHGZU2Dtd0V3UDYRp2mit1igf39qBppQRnEeP+1riazNmz6pWcrAf9Uxdp
         bo41BYJhUQ6Amn6NvPJ2u4teyO8MerHsTZqabpKS4gTiMmQC2W7kWF4SMQhcL+3v7T+9
         BBoglgXgi1zT4dPvAv/wI3kTIMjMOL5kaNlUXcQPAFHmqpsn0D4OJGuZra8Bzgut9Onj
         X1tZyNcUq8YWCIUgDhTJcjXjKFg8gUbFyCU7Kbq/MUZukEj70VGoMK4LIY0cgREAnqTk
         fA9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774270420; x=1774875220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aB63dwJ3+/i55uxvUy7eEOFEjEhDnPyKdnJvMiRZ4Yk=;
        b=d3JDjgDpbfiF5HD2OcTummEqy7cP64kQL/JpJlvWAWu51cMYJ6Okk6DiRCxD1ns/yq
         8CYaOvv2ZaOj29BOtWyDIeexq0sSlRHIVYf45uI8wILQcWvDV6xmX3i5qt/I0/9D0pr7
         tRrT3/XSmPUbq0vz6vT1Z/OhZQgsjZJ1pVXJW3YmSNHsfyou/JK74oKKdibFvbnjREvf
         wLI3LWABNhClJdkwmtAV4uKkGn3UpCPqjt8glKI9It3M03V2Wi9wB73RwjherPOPnNRn
         guM1DPJevkIkYL2I3Sx12uRXm/SfEWZemgnIuY1nOPOukZCvwh6b0wUHzDuzVV+z9d1S
         elwA==
X-Gm-Message-State: AOJu0YykY6F1jFGi7dXzbTx59nj7b4FkqytOISbUDq+joGsVSZtq9mg+
	dK8391h89V6989r77wjHHh8rMtF038qA0nIjjVXeghrtHs6PdOtGSFnv
X-Gm-Gg: ATEYQzwiXt2+n3Sf9M899QeARpE97utfWBvpW7G4bTOJF57k+3AWONkYCrAP8hQnipq
	Lnl38565thg7JERbOpK+VbI0S+mv3N7Cxcz4hlHPqXUgnh/km3hzXDKVY9duGW/QYWNltmLOqZb
	73E8YihY9bT2ntZeM7I0ECfFWVrUBgaL/AEiH7rP7rGzgB5e5C+attguaMWLMjIaWdVq8Vm14Sh
	M/mcKhR0Yg6Px+bitF9Me5EJfSmdnofygLOJTZqM/01h8Zt3RLGWPEPdL+LFqhnMTKwQV/vBsR4
	t3rhlCLU/Mlrv1lbMA+mYOaouUcbHPNHta6veLZfiSt86jBt/xC0jyYUMYACcm+ylmqdOS7lEQ+
	rOA5mMYQJ4NsPwtn0BhhFS3lfKzzJ7luPWaiMULPyRM8PPCjfiHL7QrznzBiDXU1AZj0/X4Y6m+
	/2kP731RTTHaww6VmK8qcYjI5yxmVLyJpAdZ7JcF2N0lsJO0p687fo/iDvd9bu
X-Received: by 2002:a17:902:ecc3:b0:2b0:4aeb:dedc with SMTP id d9443c01a7336-2b08278b1f3mr116383735ad.26.1774270419568;
        Mon, 23 Mar 2026 05:53:39 -0700 (PDT)
Received: from eric-acer (36-225-109-46.dynamic-ip.hinet.net. [36.225.109.46])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516877sm137522915ad.12.2026.03.23.05.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 05:53:39 -0700 (PDT)
Date: Mon, 23 Mar 2026 20:53:35 +0800
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, 
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chia-Ping Tsai <chia7712@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1] tools/sched_ext: Add __COMPAT wrapper
 for scx_bpf_sub_dispatch()
Message-ID: <qcs7xkcmkkcjwa7jrycwpyjv5kc7jgbvjlc7l7p7uvd7hrd4np@gn743phhtqws>
References: <20260322144433.1649092-1-yphbchou0911@gmail.com>
 <b75214fecccfd6256768f87daa7edb29@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b75214fecccfd6256768f87daa7edb29@kernel.org>

On Sun, Mar 22, 2026 at 10:12:29AM -1000, Tejun Heo wrote:
> Hello,
> 
> Let's not use the __COMPAT prefix. I'd like to move toward making compat
> wrappers transparent so that schedulers don't need code changes for
> compatibility as much as reasonably possible.

I think this might be another good first issue for me to tackle next :-)
I'll keep the v2 patch focused only on the scx_bpf_sub_dispatch() change,
and then I can go on to take a look at refactoring the rest of these 
__COMPAT wrappers.

> 
> Instead, declare the kfunc with a ___compat suffix and provide a static
> inline wrapper with the original name, like scx_bpf_dsq_insert() does:
> 
>   bool scx_bpf_sub_dispatch___compat(u64 cgroup_id) __ksym __weak;
> 
>   static inline bool scx_bpf_sub_dispatch(u64 cgroup_id)
>   {
>   	if (bpf_ksym_exists(scx_bpf_sub_dispatch___compat))
>   		return scx_bpf_sub_dispatch___compat(cgroup_id);
>   	return false;
>   }
> 
> See tools/sched_ext/include/scx/compat.bpf.h around line 326-342 for the
> full pattern.
> 
> This way schedulers just call scx_bpf_sub_dispatch() directly and the
> compat layer handles everything. The no-op fallback (returning false) is
> fine here since without sub-sched support the dispatch path can't do
> anything useful anyway.

Got it.
I'll send a v2 patch implementing this approach.

-- 
Thanks,
Cheng-Yang
