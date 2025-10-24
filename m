Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0EA145A05;
	Fri, 24 Oct 2025 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761268347; cv=none; b=Cl0Eac9dYj68FycjyfyRZFw2xQgKGikDaKSiK42eESQW+6bBRlqwftUcLabaSZyILXWjc7dXX0sYnERF8n5/TRg8LWB23IesWhip8bOL+c8Dut+QO3yBiVHp3PeHo9JGGQvobfXxQBf8tLqaXCTCRDNKKuvuRUUuRhYHaRtfkok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761268347; c=relaxed/simple;
	bh=nuz9wjsSyzrS89RXOZqaiUwefxbGsE7lwnuoYYdkIYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePzNXMnjKvN/oodowQmLnf6i20p3nMJ92O9HYmehJ540h/xE/t+DTybAstz3FOdfAAtrgMJC9ykZ4/pdTpelZC3pAoeMKzs0qVlsgR2HfJ0HFYeO9mcByyphomaVZK2yrowFhMNyhM/qtqX4Dog9z94GaqXGgt5YNfRp3NI01f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rGsO2UBi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rGsO2UBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49B9C4CEE7;
	Fri, 24 Oct 2025 01:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761268346;
	bh=nuz9wjsSyzrS89RXOZqaiUwefxbGsE7lwnuoYYdkIYQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rGsO2UBihKP+9bT2D9hy84LxBAgT0o7t6f98Pjpfvsze1XDdSWWW6gT/lvc883ReE
	 BUQ/+OLw/ZrbS5/P6S/NCEkK7XX+9jsFI8X0A1kHwkfHqm4Wt1z8AOnFt/RLi6ZjjY
	 zLaqMcSfcIwBGUJfW081fNaBDHCgmX2PRrf8BnqBEa7JtUfIJBat6PfPQ8ypEFOeEC
	 GuXmIPIBaQA/Z6hv+3GKuMxCk7xSMAywffMKWQQ4L3qUIN+kqvTmqkhej2maJDwF+z
	 XO0XP+ZVwgbSxmOvISXglJf5sL5vJpTz3VIK1wFb8a4P02Wjr1zFHEgVTkJA/0qenS
	 fAYpUXpore9uA==
Date: Thu, 23 Oct 2025 15:12:25 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-6.19] sched_ext/tools: Add compat layer
 for kfuncs using struct *_args
Message-ID: <aPrSeQ9560YjwXlB@slm.duckdns.org>
References: <20251023080130.76761-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023080130.76761-1-arighi@nvidia.com>

Hello,

On Thu, Oct 23, 2025 at 10:01:30AM +0200, Andrea Righi wrote:
> +#define scx_bpf_select_cpu_and_args __COMPAT_scx_bpf_select_cpu_and_args
> +struct __COMPAT_scx_bpf_select_cpu_and_args {
> +	s32 prev_cpu;
> +	u64 wake_flags;
> +	u64 flags;
> +};
> +
> +#define scx_bpf_dsq_insert_vtime_args __COMPAT_scx_bpf_dsq_insert_vtime_args
> +struct __COMPAT_scx_bpf_dsq_insert_vtime_args {
> +	u64 dsq_id;
> +	u64 slice;
> +	u64 vtime;
> +	u64 enq_flags;
> +};

I think this makes the inline compat wrapper to always pick the compat
interface as it'd do bpf_core_type_exists() on the __COMPAT prefixed type
name which doesn't exist in the kernel.

Thanks.

-- 
tejun
