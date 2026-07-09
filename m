Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6533347BAF;
	Thu,  9 Jul 2026 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636114; cv=none; b=KIowAbuheb4SZtRWiAO23kkXfm8m3U/nJQcH9wHsOeInoh5nsU26bKu/D1I/2wEAjcP74csgbKdFAkqg1E61dlkBQZg5zUUduexQO/VTDEWEjbZ3sacMII/2mg8ljV2Nvz66XAWNKdarRLeLL3fIWW07JxK1Hu+q5P0CaR3pVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636114; c=relaxed/simple;
	bh=8XHFgR94xk1hTAk4vfWkGTC2QZYhz9zaohoQHSFn0z0=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=GmZ+/gBPFyUyCh6sCtMIMDHFHC37ZKAmx0lBrcHzJTkH2EESh2YiTpItADkotHf0gEJNeN9U8q6+kMtZrGYhQIKjCxMKG/CL1v/i+oEu4cQTEE/YpQFb/XRgE4sWkdBMkH77jOgd5IiOMmzsiPk8+oNXCo1yk5ehWDgu2V1fiPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5A/sHNM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5A/sHNM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8DD1F00A3A;
	Thu,  9 Jul 2026 22:28:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636113;
	bh=HN6Y7C7SIYl/RxAYe8DQvIYfv+Lrykjqqt/hvBZJmpI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=N5A/sHNMZEQJ1oZOyoiDeCMQAeluDH4wX7dmoKHhChZ+IE7taMhem+mQAbRPEr5TW
	 D38JNXPuX0prHjLidczgQhxkJ1ZSzea9RgozUcJEcdzt8bdtlLg11mAZBe8q/CaTNV
	 0s7jaon0LSzyX1kKuXFTx5uXVN7CAcyIjDrRTvy+cxh95ZpHvV8kFHsuM+no0Az2J8
	 rHnbGZDosshz7DuXGh85/GGEDMcxgW+rzTEK5dhZQU3JMn4rO9kAfGL5hL+zSWnGZx
	 xW367svT5QpqQk7t/fBTuhT3AxC7oUXm3JwF+BKHXs/FZB4bkcdNWT6DbTnBvsYhbX
	 rUIJOqTQMpzVw==
Date: Thu, 09 Jul 2026 12:28:32 -1000
Message-ID: <f3be2f04e4e0703860b4db5d0c27a723@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708214121.ABDD61F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-9-tj@kernel.org> <20260708214121.ABDD61F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 08/40] sched_ext: Reject direct slice and dsq_vtime writes for cid-form schedulers
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 21:41:20 +0000, sashiko-bot@kernel.org wrote:
> - [Critical] bpf_scx_btf_struct_access_common permits BPF_WRITE to
> PTR_TO_BTF_ID | PTR_UNTRUSTED pointers, allowing arbitrary kernel memory
> writes.

This follows the same btf_struct_access contract as the other
implementations (tcp_ca, qdisc, hid): the callback validates the type and
confines the write to the one whitelisted field. Whatever the register's
trust flags, the store can only land on scx.disallow, a bool which only
gates SCHED_EXT admission - not a useful write primitive. No change.

Thanks.

-- 
tejun
