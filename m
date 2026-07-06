Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD843BFAD1
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381242; cv=none; b=sBQFoCv4RgJBVtX/S/CU5u5LoZKL4KWamRrjpa8t7b/qVR5IzbCD9N9VjwDux5esbpowFkbRmrlML8jbqaS0KtKyKZCubb6Er38oxeRx6sIDbCjnF4nLU6L81jvbPrmpusgueOBtdWoPmxwrxQWoVVE+/Qp54V3dvpr2gXJo75E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381242; c=relaxed/simple;
	bh=Dqr8X4fp9JZULxB+V1KtmEn7tCtRjYPbTRDps1VXc1I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=jNU8JNTBbhl4DQmpDTVgcFD5uqkm/zz6ZMJ7LfqaxFRDvGxvBysvUbQCGqmTRFpjyIbZx9PCnAYh5MXLmDXWUUV2ZAfnxFdeYTUbqqAm4iRWhwywPurpo8/1Mcj1K0+ZWKrBpdfZYFwxzMvYcj3Go5goF8ikt1KZ50x1+KfQvmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbRg/Hvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbRg/Hvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D672C1F00A3A;
	Mon,  6 Jul 2026 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381241;
	bh=Dqr8X4fp9JZULxB+V1KtmEn7tCtRjYPbTRDps1VXc1I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WbRg/Hvcjwlzk6hyYbMpRlSgsBqhEMzPddYYZvfdOzD3NB65Ez6bVczVNuNhv+y+Z
	 l6V1h8QmxpqCcOSHw9zpFNejIxVBscIw54b2A5PDOKfTdYn8CPcISAMvlZkuywjdRG
	 7Bw/M07L9qJ6OnkL69qCZUx6zigCBDHnfOIoFj6qCJSBZ4olzpeMIweF2i+o8GgxKT
	 7Rnuwsy65fhkj3cGKg1KgU8wi0T+M1hDJCFY5riOTZQbT6GFeQCeBr2DmCnd44hKcz
	 5sW28sHRqgF8ZE+evqkVGiaR4lW2KDbKkGTA+CLnCAyuLL0/9COReKzn3FjbnMLuHS
	 txdVJQfhnuetg==
Date: Mon, 06 Jul 2026 13:40:40 -1000
Message-ID: <f6b4606f1fc53cbaa2ee9ea314849374@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 15/36] sched_ext: Add scx_cmask_ref for validated arena cmask access
In-Reply-To: <20260706015840.5CD561F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-16-tj@kernel.org> <20260706015840.5CD561F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 01:58:39 +0000, sashiko-bot wrote:
> - [High] Non-atomic Read-Modify-Write in `scx_cmask_ref_or` and `scx_cmask_ref_copy` clobbers concurrent BPF updates to adjacent bits.

False positive. The read-modify-write targets the per-call kernel output
buffer while the calling BPF thread is blocked in the synchronous kfunc; the
authoritative cap state is kernel-owned under pshard->lock. The non-atomic
word ops are documented as tearing-only on that output, not a correctness
race.
