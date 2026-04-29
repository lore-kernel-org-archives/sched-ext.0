Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E6641B356;
	Wed, 29 Apr 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487370; cv=none; b=hSHoC+xTPz/yOE3euRUtinQrV5Iu1z+pBirTc6zX1guD/YLEGVRERr+BbkKQ6solN9c7YWe6bKVwGF/DgqazUeMURl82pJq/mq/orGN7LE2Nm4LgXSpgCivHNJd6fViOqyrtyErCP8yF4eb7RvMrWmTNqObwEsqOs73a7A+az+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487370; c=relaxed/simple;
	bh=zRPwqtMCUQqP2YFKgvX1xfSGFqslc0okhCxRXrd5B9M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=pYJyG2fy5N9F1vJDlcIFPD8lxCQSsbHAxSgjTg2YNHSq9KGYuuxrLvskuJrewTCimH4AkB0m2ceW5EsBG0MMB2KL68BKbqITPU/lPy+/tqwsyxauVvuIlnlS7/ApXd84yx6wmwcmHX5LcAEc8+BNZ0wdFV5/XIgcceNKqZ+Zzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SJN4DR7k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SJN4DR7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE48C19425;
	Wed, 29 Apr 2026 18:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777487369;
	bh=zRPwqtMCUQqP2YFKgvX1xfSGFqslc0okhCxRXrd5B9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SJN4DR7kQSJjiFYjsqgDr/IDImiHbebqIti/UzJ3fU3dHQVxtBPt2n/sEyj69MQxm
	 ij5omtx6qnZ2EXj5qet8jEO2e31U9OMgy9YJ3ppCJ0aRFO6HIhuvLRNf8oWY70SYiv
	 txbPfv25+uk4icZyVpIzgHlKa2v2Eht4JiNa7iJ37frW6xdTNJPE8ANxiCIjFEymRE
	 xD7a5WJfNIFSP7bIWMCyndy5IxqYmgmewG/ehonek+zX2cjz4kEBr5PjjRHJGzU6tM
	 /Iqmtx9O96r0dB2+VK9F2gVIha+p26SzNtZm5ax0awqgIlXIRlL0mvhjwhwoLak2ek
	 mJH/2O7BsrsQg==
Date: Wed, 29 Apr 2026 08:29:28 -1000
Message-ID: <e784a3f81fc227c4db2bdc1ef585a705@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v4 sched_ext/for-7.2] sched_ext: Topological CPU IDs and cid-form struct_ops
In-Reply-To: <20260429182131.1780125-1-tj@kernel.org>
References: <20260429182131.1780125-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> Tejun Heo (17):
>   sched_ext: Add ext_types.h for early subsystem-wide defs
>   sched_ext: Rename ops_cpu_valid() to scx_cpu_valid() and expose it
>   sched_ext: Move scx_exit(), scx_error() and friends to ext_internal.h
>   sched_ext: Shift scx_kick_cpu() validity check to scx_bpf_kick_cpu()
>   sched_ext: Relocate cpu_acquire/cpu_release to end of struct sched_ext_ops
>   sched_ext: Make scx_enable() take scx_enable_cmd
>   sched_ext: Add topological CPU IDs (cids)
>   sched_ext: Add scx_bpf_cid_override() kfunc
>   tools/sched_ext: Add struct_size() helpers to common.bpf.h
>   sched_ext: Add cmask, a base-windowed bitmap over cid space
>   sched_ext: Add cid-form kfunc wrappers alongside cpu-form
>   sched_ext: Add bpf_sched_ext_ops_cid struct_ops type
>   sched_ext: Forbid cpu-form kfuncs from cid-form schedulers
>   tools/sched_ext: scx_qmap: Restart on hotplug instead of cpu_online/offline
>   tools/sched_ext: scx_qmap: Add cmask-based idle tracking and cid-based idle pick
>   tools/sched_ext: scx_qmap: Port to cid-form struct_ops
>   sched_ext: Require cid-form struct_ops for sub-sched support

Applied 1-17 to sched_ext/for-7.2.

Thanks.

--
tejun
