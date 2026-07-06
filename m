Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268533F889E
	for <sched-ext@lists.linux.dev>; Mon,  6 Jul 2026 23:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783381243; cv=none; b=foF0A2As1FtwjxfD+zNRs0arpO25cAiT0ypmpI8KWa4+O4WhMcC3yQUAXu4jYkkwffHg1/MBCwVKGoqlo7g+IlkiYkqCD0hDjGT4jciysoUGlrySZ+gGdV8e24nkzfDL4kJdoY6yIU+lOIvrS1zTmZLTSreVUmePUaxeUjIjQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783381243; c=relaxed/simple;
	bh=wZ1JfbYgzweux9r7GIlHjD65TSMuL4Ygp22PBaMBp88=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uyMto3bY3I7b9w7OoRbjDrm4XqjQFktYzHjLjYHZNgVjPfEcYtGH42o0QvXcXE3ClFo6z/nR+V8XZsoUOFVQeJVne8vZz3YAjdY5F4K+AX8jV52EOHcpMGjIFnU5yqTbtRGsgbhlxsDgaHge2lvJKz8lFEtkChFflLHbA8fLusg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qvi39/9I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qvi39/9I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B071F000E9;
	Mon,  6 Jul 2026 23:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783381242;
	bh=wZ1JfbYgzweux9r7GIlHjD65TSMuL4Ygp22PBaMBp88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qvi39/9I21AP6yLBzpqvRA6C2f1FctZf7wZh9eIDogVKesdH1LkYu1j5v6aEGCabc
	 HxTlDOg0pBpSxhRbRZXU8ERgg1J+OpMgOizDOH6pvYzejVQ6e+eHNB99QY2BL2JNhS
	 V6qIGJMNxFwcIMsLiIEUxQVjvzIknlwK5noiSFztH4o9lJHPoFP4BjmCcQQSXJ+QR5
	 OiTOZ1nCO99F0oUQ9rMBDOlaPu5nw8xCcLcvcmNlVT025ZKboUD7RW72I/+4h1ML3g
	 ucz/RiITiFCl+cOiaTZzez3k0/IHKRGeSSrzZBBH6lo3BIm/BUUXJ6hZjOYC6ng4Ma
	 FnhivIcD1QX3Q==
Date: Mon, 06 Jul 2026 13:40:41 -1000
Message-ID: <93de087b3267e43e6e95a5c511bc9cd2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH v2 sched_ext/for-7.3 16/36] sched_ext: Build the set_cmask scratch from trusted geometry
In-Reply-To: <20260706015927.2C4C81F000E9@smtp.kernel.org>
References: <20260706014058.439853-1-tj@kernel.org> <20260706014058.439853-17-tj@kernel.org> <20260706015927.2C4C81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Mon, 06 Jul 2026 01:59:26 +0000, sashiko-bot wrote:
> - [High] A concurrent BPF write to `alloc_words` triggers a kernel panic via the `__counted_by` compiler-inserted bounds check.
> - [High] A BPF scheduler of cid-form can trigger a NULL pointer dereference (with per-cpu offset) and arbitrary memory corruption by defining `set_cmask` without providing an arena map.

16-1 (__counted_by): fixed for v3. Dropped __counted_by and folded it into
the scx_cmask_ref patch with an explicit alloc_words capacity check, since the
compiler bound read a BPF-writable count.

16-2 (no-arena NULL deref): false positive. A cid-form scheduler hard-rejects
a missing arena at load, so set_cmask is never reached without one.
