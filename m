Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817883E0C7B;
	Thu,  9 Jul 2026 22:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636124; cv=none; b=jnXZuPUXY8vgOyuket3MVTGUQx0JsauPpUb9o6SJt102BDFlnfxJT0YFno3sg+uktI1FN7syA5dwEanqjHIjwMaoEXkGdivH7NaDXMZFDONringuA/LA6tYOVDt8nHCyLh1r2UpwH7v6/cKG7jSBgjo56iRfbUwQPei1kIHwSCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636124; c=relaxed/simple;
	bh=D96dwjje24jr8w7xSkguDOOxJ2ndpqnnXTKp4ysyLKw=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=VG6GwPeavtZqv1U+7OSFvFlWGjBO0wtZsh69NiiIYlQopYGgKn/nwSklqVqGsLTwu1v2kxWB4/T6Pw3c7hXW+FYe6GG7GTw+3+ksMfNKlHvHA3wFMt5XL9PMY+jD5xxR5nTOSB6O6WAFvlYnxMzYPjj7aArP1dN1cL+y4mM8ZF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfcoQIi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfcoQIi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F811F00A3A;
	Thu,  9 Jul 2026 22:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636123;
	bh=hdH1DcnXXrMmmTL/EcrfSwGy9VCl/GOxpCv5y0lWBoI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=nfcoQIi6Rbnzk9YoOgqHwYXmn2NBWatrw+Bt/MVI7ACjZ1FHVJ9y67kX2+HIYh4S1
	 uLTNYbe8qyOHrIsJEMmbRve64sWR43enfIR+9onAqxH1Mm8AfbwrIOI92NmTJ1ysB4
	 0SfL1gsH70hf93S3Cw0D8D3JQ9P0jk6L22as1VR6oTM7xPXlPzI0hhQkaOPiwHtVIj
	 prq9Ll5r4OhaHM9j2Ykq2tg+hS2nSS8mM0UgsgzWdQr6MsKN9W7HAv6bjot/EUyuaC
	 Nce513Q3pwNTsPjJy4hckI1+fgT0CK8dXS6Z+VCCqIYFVyLTsIsz68NFlwUMfLHgDr
	 OLopUjNL/+Vvg==
Date: Thu, 09 Jul 2026 12:28:42 -1000
Message-ID: <bb683eba3542a034df201ec2d800c74e@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708215657.DDB5E1F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-28-tj@kernel.org> <20260708215657.DDB5E1F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 27/40] sched_ext: Add the SCX_CAP_ENQ_IMMED cap
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 21:56:57 +0000, sashiko-bot@kernel.org wrote:
> - [High] Tasks in a bypassing descendant's runqueue can be permanently
> stranded if their nearest non-bypassing ancestor lacks SCX_CAP_BASE on
> the CPU.

Real limitation and already on the known-limitations list in the cover
letter - there's no fallback yet for tasks a sub-scheduler can't run
anywhere. The plan is a root-reserved fallback slice in a follow-up
series. Not new to this patch.

> - [High] scx_caps_for_enq() unconditionally maps all local DSQ enqueues
> to SCX_CAP_ENQ_IMMED, allowing sub-schedulers to bypass isolation
> guarantees and swamp the CPU with non-IMMED tasks.

Same as the v3 round - at this patch ENQ_IMMED is the sole baseline cap;
the ENQ vs ENQ_IMMED split that gates non-IMMED work lands later in the
series:

  https://lore.kernel.org/r/70c37a43b2eb1e3d54238c02851f0b62@kernel.org

Thanks.

-- 
tejun
