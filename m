Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318F6427FB0;
	Mon,  3 Aug 2026 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793037; cv=none; b=slKe9YthvwUoinf/+UrS4j6wG54ct0MQT/fzAeu/XlhS4uc8WOJw2VhPCgiWSBE8Qbbu62lVT6m1W4YcS/R+EVRGBUmBZph30oXYQqwec6Rxug3EafCdyz6OgpzSjW4uT5L/Op8nox1Z9Nj/ttAGS8S7wJ45nFJ1IiBAE/5oN30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793037; c=relaxed/simple;
	bh=wTEqzMoDwB4bmJX35lmD6QPUCOEfGCBOQvI4z2kODMM=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=t2qgTj+Shx1U/2wQPlauGDl+vKSAovi5rdZmYnAxX40nkQXpUix6TIoPOfrltGf9oLxRgeO1kyfcmvVAhu5g8JcdmThrOczh7cdNcJJB5Q3ksO9IqUvAZRrdlZ53FxVTbtWfvzQJb9nROKJOtdZHaRRUkoO705O8vqvdSrhmRsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzRw3Oww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzRw3Oww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E13C71F000E9;
	Mon,  3 Aug 2026 21:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785793036;
	bh=qH58n4jn1doVzN7VkP0a4KB/FjDJE0A41d+W337rsdQ=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=jzRw3OwwF0ZDvVhxnPbr8RO8bquU/1Ll8mxyZHLwWp9TJ1EEOQEFUPEERaJy91srO
	 WdPG3RspTlqVEYvPuzpTpM1K1p/y9gLh8emmusDvztD4sp1IZDWMhMX4WRRWuoUYnr
	 vT+03K+aAQTb7+A/dEI5CecnufJqz7AbxMnTjzXCdsNQv9K77wIUsWsOJmEkSwhpL8
	 pfO8KcSJLftQzb/hM4k59b1zAMEk9Bi7AKMvh+A+l1Abb9PmpBU+qH0T+jmIpCJJAV
	 AjdT2oWLaKE9bx08wc7QVJ5loF3RXh6zIGIT6OIhap8R25ZxiZuV07LxFI2FSnJlw8
	 gggKET4QjcdNw==
Date: Mon, 03 Aug 2026 11:37:15 -1000
Message-ID: <4c18ed944c25389edb1fe74b64ed6da3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20260802215447.3134509-1-tj@kernel.org>
References: <20260802215447.3134509-1-tj@kernel.org>
Subject: Re: [PATCHSET v2 sched_ext/for-7.3] sched_ext: Bandwidth-limited
 rescue execution for stranded tasks
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Sun, Aug 02, 2026 at 11:54:35AM -1000, Tejun Heo wrote:
>  0001-sched_ext-Rename-scx_local_or_reject_dsq-to-scx_reso.patch
>  0002-sched_ext-Make-several-ext.c-helpers-available-outsi.patch
>  0003-sched_ext-Factor-out-__scx_bpf_now.patch
>  0004-sched_ext-Reject-internal-enq_flags-in-the-dsq-move-.patch
>  0005-sched_ext-Make-SCX_ENQ_IGNORE_CAPS-waive-the-preempt.patch
>  0006-sched_ext-Synchronize-slice-and-dsq_vtime-writes.patch
>  0007-sched_ext-Add-SCX_TASK_PROTECTED.patch
>  0008-sched_ext-Add-bandwidth-limited-rescue-execution-for.patch
>  0009-sched_ext-Eject-the-top-rescue-consumer-on-overload.patch
>  0010-sched_ext-Sync-tools-autogen-enum-headers.patch
>  0011-sched_ext-scx_qmap-Idle-check-pinned-tasks-before-di.patch
>  0012-sched_ext-scx_qmap-Add-rescue-support.patch

Applied 1-12 (8 in its v2 form) to sched_ext/for-7.3 with Andrea's
Reviewed-by added.

Thanks.

--
tejun
