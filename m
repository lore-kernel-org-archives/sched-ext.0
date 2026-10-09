Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033B84825CC;
	Fri,  9 Oct 2026 20:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791576254; cv=none; b=KYwsRug+cTCJ7eV2RhgqRIHg+NIttOmGvViVMuVsN6XeUBkrAYv99US2Jr4pGbCcQ/ad4AFuK1vSdOFFw6ExQMrdTvu/iGobkY+nLRbx1hfnqxwlssn+m8GSniPmemrdmDNLo1T41sIS9ERdG5jmblw6cqmirGe+KsVB74fsPb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791576254; c=relaxed/simple;
	bh=q90MfB1WbwcgTZBwGtSk+qtq5zTz1htIwlOTMj/98iU=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=SLQb9kYlPFfKj7bb6mycMPd+9EzlBd3qminw2QqTUKo76x9CI1M5Eqr3A85TFD5HKCAab3A+/14RhXKRsmP0hMUaxprtHgFZdvHDv4sRymzSckoQMyYHUcldYttDTDJb2sWX23NrLfWW4XyuHvnqm+huN2r3xw4Ud/tfwrcE1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edcKR0HW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edcKR0HW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B7071F000FF;
	Fri,  9 Oct 2026 20:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791576252;
	bh=q90MfB1WbwcgTZBwGtSk+qtq5zTz1htIwlOTMj/98iU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=edcKR0HWezu5RtfQc8EoMVIi7ww/m3UBTJkW8hm7/xzOeVCyKSqtztxCR5OiGfykT
	 CcWnOA9U7QRIiCqame06554eSiZ2aeahPwrtRfFNxo1WFAzm5ykBWTXXx9Cwg0WWPd
	 kK/UGXqow3GLwMkpkHGM+jSOFDRNFWhcLWFpvUJsQtS+umYRfuNXfrxUXrJiGL3NBu
	 bZUGx8QwOCKc2Wt/qA7Ac4aEoqQ5hp8J9NJ+ptcuQ2v2VPgNpIS7U/SK8pX7OT7gXK
	 BqXPbLQsy8i1oVuuwbQmPvNyMBkmBYR/LTs4xUSmtm5gc37g3XmTkVT7Xq9mC9VUbZ
	 +QSy+ZvM52iBw==
Date: Fri, 09 Oct 2026 10:04:11 -1000
Message-ID: <75b599f5c3e38cc62e33c4bf370a1d84@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add ops.sub_child_ecaps_updated() to
 report a child's effective cap changes
In-Reply-To: <asjNO0ggCPcfIP7Y@gpd4>
References: <20261008093228.2015427-1-tj@kernel.org>
 <20261008093228.2015427-2-tj@kernel.org>
 <asjNO0ggCPcfIP7Y@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Fri, Oct 09, 2026 at 01:17:15PM +0200, Andrea Righi wrote:
> Should ops.sub_child_ecaps_updated() still be delivered to the parent when the
> child is bypassing but the parent is not?
>
> For example, the shared pool may rotate away from a bypassing child. IIUC, its
> PERF revoke takes effect at the next dispatch, but the child's bypass state
> suppresses the parent notification too. If the child is being disabled, it never
> leaves bypass, so the parent only gets ops.sub_detach() and cannot tell when the
> revoke took effect.
>
> Could we notify the parent when the revoke takes effect, even if the child is
> bypassing, while continuing to defer the child's own notification until it
> leaves bypass?

A child can't enter and stay in bypass on its own. It bypasses during its
own enable, which is lifted and replayed, during its own disable, or when
the whole hierarchy is bypassing and so is the parent. That leaves disable.
v1 reported the revokes of a disabling child and it got nasty because the
calling context differs from the sync path: the dispatch kfuncs needed their
context set up outside the dispatch path, the nested sub dispatch had to be
gated, and keeping the report clear of the PM bypass took a lock that could
stall a suspend. The simpler contract that works is that ops.sub_detach()
covers a disabling child. All of the child's caps are gone by the time it
runs, so the parent restores what it delegated from there.

Thanks.

--
tejun
