Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EC23E7BB0;
	Thu,  9 Jul 2026 22:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636121; cv=none; b=qurpqX9KQWZmRg3JzUxCnTT2AlhxtUK/p+Q7wk1geviSvPyInvKKdc7y7IEZehGV31wSaqOgj5yZbkj56OvfkdOMHgeJ41ImIGjsskfnn8Ic+KbsrMXX5LgyBnwMXHdvw/CZXILWf1zMaTP2Ou19kRNxDvBo4hwwDK+9KCkpwR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636121; c=relaxed/simple;
	bh=uu7brrMUqtCTCfWGUE0L+Vni6nj4N89bi8iVBWazwN0=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=ZWJChjRkxgxuM8yewA+OWB5OFswgnaWVYnIgjlsuUMNW46lUTIKOa6wAUWkOHjnYLRXspqRCermCtYVupQPYvBG2JAfkL/l1RQ4SwCF418cvBpccgCxekBtZemUWKL1oOU0AZVEH2Ex1ZBiE+JzBUlFZAV/LCkTwGF0MUS+GlAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vii9Cj0O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vii9Cj0O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF521F000E9;
	Thu,  9 Jul 2026 22:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636120;
	bh=amW6bcxQxoT0MM0fRzbR5S+fIU30Ur8mUraIm9euSsM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Vii9Cj0OsXy5t+1K5GVEXjlYL2LGjZeBiLOSR94txBKzuWs2nYyecOI3WKm22dCkJ
	 Zx9cUXOiLGpt4XgwtkpcM9OdJlDNSF0xXwQlfdTp3+PvuBaISy8YC1kHRnVFrt0Y/V
	 vnDSUURWu5DBgKZVEx7YVNBLd57/naumFZlza07VzpCldo+HZ1KvMFHADhmGqRvFND
	 V6nAstIxzofa/vF1CopVI6kCWkF1LgaW8UEaWhAr/2jnaG4XK44/1RMFki+aLdBsTH
	 xagLEB1oqPPY0i0AOwryExtx6GACl2EQAX9m9kiFZRfZzRbjczNyihHcNb4CrrU7Tu
	 SUpAGV+8MmWcA==
Date: Thu, 09 Jul 2026 12:28:39 -1000
Message-ID: <2b2de4c52ee27db1df171919c91823c9@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708220057.20F581F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-22-tj@kernel.org> <20260708220057.20F581F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 21/40] sched_ext: Add per-shard cap delegation for sub-schedulers
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 22:00:56 +0000, sashiko-bot@kernel.org wrote:
> - [High] Missing validation for unallocated `pshard` arrays and missing
> arena maps in `scx_bpf_sub_grant()`, `scx_bpf_sub_revoke()`, and
> `scx_bpf_sub_caps()` leads to NULL pointer dereferences and invalid
> memory access Oops.

Same as the v2/v3 rounds - sub-schedulers are always cid-form with an
arena pool (enforced at attach) and their pshards are allocated before
the sched is published, so these paths never see a NULL pshard or a zero
arena base:

  https://lore.kernel.org/r/d302edb6cfe897543505d691705e9ea9@kernel.org

Thanks.

-- 
tejun
