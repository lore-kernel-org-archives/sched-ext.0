Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50923D1A9A;
	Wed,  8 Jul 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783537776; cv=none; b=bQLi/tgo4Euh7R9OCTULMoYQcEN3fLySuAgfWhmxp9ii+o/s/wGGwecQxMZjj0/sa9V+LObS0xZBggiuC4VjjUrFuyp2hWQd9cfqJrU+RFcU15w2IrToYUnhPPCrl9B6B/iUDAPFZsEHlY8ZpSib9sCZuPTHuZ2sGY637rCUIOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783537776; c=relaxed/simple;
	bh=8WaMrWuRYfhN7V2h3fGFpt1727isud1EJEPaE1DSuOk=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Z20ncfIvAVtt78oa4Y3Fa2tJr+woTqDWvaQ/8BeuW8FWCRxyH09lfxCnvFMe2v6X/7GAIsiS7U22S6nrYH9gD/0ebw3pVshzJ6KBQllNf2DOxGcHUIlOdi+GCVjlJ5MBB5A7nfvnjcNtZ4YXWTzJkJACYTgTp5SC1e0eljQj2vo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp1Rt3uW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp1Rt3uW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347D41F000E9;
	Wed,  8 Jul 2026 19:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783537774;
	bh=l2tzZbQBFXoM//wU2Inj/U6UpkBDm2zitaDY2u23IpE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lp1Rt3uW2osCQbq84I3A/+IaYZXB/X2hU7KWrxekobXFshjAXLte+5tN8VuGY0x61
	 NJat34RnzakDHCiPJf5i9KdbX6c7J7+GmjcgH7o81h9e8hanFgcADqULqTiYKBctHM
	 EJFdHtwAiZzU4Ltb45heWG3T2x7Y2K+vgn8hOzHNb52G9TSABOWqZOEdUSfq8zA6Aw
	 bLjJ1TdrCcNLKQ+6aQ60hw2jei/qZvUPFgFZpcVvsCxg6kuT2Iu8RZL0LX80MkbHkR
	 HUzpHBYO4zmoTmYoSEry2VEE5S70PgqIUdCNE0WPW4j/FmXS+5dndIiFZBURXXWWOs
	 h/xdsSDjxV+FA==
Date: Wed, 08 Jul 2026 09:09:33 -1000
Message-ID: <a65afb799f333a30312d3ce3f87abe9a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext/for-7.3 13/36] sched_ext: Defer scx_sched kobj sysfs add into the enable workfns
In-Reply-To: <20260707003134.A81DA1F000E9@smtp.kernel.org>
References: <20260707001229.1410929-1-tj@kernel.org> <20260707001229.1410929-14-tj@kernel.org> <20260707003134.A81DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Tue, 07 Jul 2026 00:31:34 +0000, sashiko-bot@kernel.org wrote:
> - [High] Moving sysfs addition into the new `scx_sched_sysfs_add()` helper introduces a new silent failure path in `scx_sub_enable_workfn()` that leaves the sub-scheduler in a half-initialized zombie state.

Correct - at this patch the errno-only failure path had no scx_error()
to claim the exit, so scx_flush_disable_work() no-ops and the sub is left
half-initialized. Fixed by adding an scx_error() at err_disable here (it
previously only appeared in a later patch).

Thanks.

-- 
tejun
