Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D3A3E1CE8;
	Thu,  9 Jul 2026 22:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636119; cv=none; b=Nj3Y/jlz5eHuz+u2XrUiog/T3BGI05mm59eM60n/GueKRxlUN1o7Aeml4pVhuQJYA+CKaRt2xf7f5W7q5fIcXPI5TptTpkvkTKoaa9TIVdhR3Oq527m1zGbRpBE3/CTxKXW4k3pQRhqhDa+96tn7bqAvP0xEPYixfJj8MrcSL5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636119; c=relaxed/simple;
	bh=eFKmcabWEXO2xkDSlWPOLEXEvk7wXVE5MrIBlWVZj10=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:References:Subject; b=IQ5LjfuSg62t06rXdcRyC8lfP8nSE1Tl8cphUJ8IV/ppnc7fP8pHxYuIPLokS3dHyKvT4bCcPbpVY8lZBZUMjsBz0IyyQIEAkUmznJki3IHtk3tBa7JcxExcOkq4baAmw7EEuiGlTV45dADGIx/Hne8BW85bEpyniP4VjnWW0s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP7N1Br/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP7N1Br/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6F71F000E9;
	Thu,  9 Jul 2026 22:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783636118;
	bh=8/IJkaV9R3OmGbQV5zp3U0ba+0DRBfHcqlq4PJHe2l0=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=hP7N1Br//IGgC7/g/ux9/rpNrJHJNGTE6ahWfRlqmRh3CAhtz5Zu1PyFCBpQY3TKe
	 Yn7vJdcx2fVRQjIfn7V6BMzW/z9/p5IZ3oly3arpZFUrIaxrNd+jEV96pJGpTIYcHW
	 gXSqdTBpur7IbyjhPfoVqCgjnbhH1XWfchKCqsSrqQBBmvuFlgXL/gYnDuO3hV5BLS
	 Ar/rMHL0JF1K3pOb/ouHLHCisG+jaqIgg+uhaZlqt7Zx+Hy+cvuB2/1/myyeKyee6q
	 QtUl4xw/e0zH3NPDVNknPio1ud09HblmO4vrA659wsvnnzmi9skL8rvBklvRnIDP8R
	 F9Gtk/CtoS4Mg==
Date: Thu, 09 Jul 2026 12:28:37 -1000
Message-ID: <72a0cf5923366f218fe3ed812a4169ad@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20260708214419.34D441F000E9@smtp.kernel.org>
References: <20260708212429.3405787-1-tj@kernel.org> <20260708212429.3405787-16-tj@kernel.org> <20260708214419.34D441F000E9@smtp.kernel.org>
Subject: Re: [PATCH v4 sched_ext/for-7.3 15/40] sched_ext: Add per-shard scx_sched storage scaffolding
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, 08 Jul 2026 21:44:18 +0000, sashiko-bot@kernel.org wrote:
> - [Medium] Missing scx_alloc_pshards() call for sub-schedulers in
> scx_sub_enable_workfn(), breaking shard scaffolding.

Same as the v3 round - scaffolding plus the root allocation only. Sub
pshard allocation is wired up with the capability feature in a later
patch and nothing in between touches a sub's pshard[]:

  https://lore.kernel.org/r/7513197a6ed81817b3326b52b23fad74@kernel.org

Thanks.

-- 
tejun
