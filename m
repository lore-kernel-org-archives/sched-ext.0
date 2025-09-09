Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B01431D389;
	Tue,  9 Sep 2025 20:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757448077; cv=none; b=CuTVEtlmgno+7TihSu4q6jtHoSqYVILMzNVrjIsNi0SSfWeWAKWKXeU1fORbSYXN6pIOocxWZAQFr1EtN9CBeTFBcTCBtiBTDo+mWNE3HClFlKA8ryzyuRgWocZmaKhCTVyAUr8JCvc2vj1ikOYtlK8BvuIgAuPECwgV2y8dJcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757448077; c=relaxed/simple;
	bh=DrmTl+YJ00N7l0CTHFWgCPFQoXdSb9POkuHsvK8NRRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U/XKnawP7UojkT9oeQmdrgAH37U+Sb0ACXWu9tnGXAQbsvd2bAKTTy/5UZt0kc1iDHYvb/ji+G/JBnbGCHKjG4fkJIcGj+gAwwVe3NcLJ0BG1HCCo2NHmKiUTVWKCNgXdNkTcsckTL7Pxdy5MwTsSn+U5mmBcAe0t7D26veWzg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOnLUdOI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOnLUdOI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B7FC4CEF4;
	Tue,  9 Sep 2025 20:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757448077;
	bh=DrmTl+YJ00N7l0CTHFWgCPFQoXdSb9POkuHsvK8NRRE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oOnLUdOIk4Xors9fpFWskd+rUnMb/4Fj9PAjQbQ36tFQBkSaKqbfbJtq8Keo6l1d6
	 A0qXbWBnA/HqeywOMV2HLWP/VQeaV7tOy+Jd+P8vtu6f+oQz35oKjRGD5Fqxar9izO
	 gwcpIscu7LbOwMx6JAQeohLxQql7tEtSrU8uJMG09ZLWL13Bf0FZxKHxfl+D+myuRE
	 PIjy8pKzvrBLS+2M50bY3dMIuV0YFMfeA9uDQ0DY80U/d+ItyAM847Ju175J3wj8NV
	 z+aSQfg/m3wOMv3jv+8990bHRwUHJvXYorNtdrHIzIHhhTPs0FIKV/B9+h0ZScfrY+
	 PSIwddu3PMKJg==
Date: Tue, 9 Sep 2025 10:01:16 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Christian Loehle <christian.loehle@arm.com>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-6.18] sched_ext: Acquire task reference in
 scx_bpf_cpu_curr()
Message-ID: <aMCHjFwwjqvKsZBg@slm.duckdns.org>
References: <20250909195709.92669-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909195709.92669-1-arighi@nvidia.com>

Hello, Andrea.

On Tue, Sep 09, 2025 at 09:57:09PM +0200, Andrea Righi wrote:
> scx_bpf_cpu_curr() has been introduced to retrieve the current task of a
> given runqueue, allowing schedulers to interact with that task.
> 
> The kfunc assumes that it is always called in an RCU context, but this
> is not always guaranteed and some BPF schedulers can trigger the
> following warning:
> 
>   WARNING: suspicious RCU usage
>   sched_ext: BPF scheduler "cosmos_1.0.2_gd0e71ca_x86_64_unknown_linux_gnu_debug" enabled
>   6.17.0-rc1 #1-NixOS Not tainted
>   -----------------------------
>   kernel/sched/ext.c:6415 suspicious rcu_dereference_check() usage!
> 
> The correct behavior is to acquire a reference to the returned task, so
> the scheduler can safely access it and then release it with
> bpf_task_release().
> 
> Update the kfunc and the corresponding compatibility helper to implement
> reference acquisition and prevent potential RCU warnings.

I think KF_RCU likely fits better for peeking kernel data structures than
having to acquire/release them. Can you post the full backtrace? Is it being
called from a sleepable bpf prog? Or is it that we just need to expand the
rcu check scope to cover regular rcu, bh and sched? And, everything aside,
if KF_RCU, should we be tripping on rcu_dereference() in the first place?

Thanks.

-- 
tejun
