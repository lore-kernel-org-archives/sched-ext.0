Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C31A42F70E;
	Mon, 27 Jul 2026 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187491; cv=none; b=lICFfppeEK0dsYfF7T9caDdLDADEFGyQENOPeCW8CvJLJZk+I7/LQ7r/Ih/ZNyEpK/P5fvccHZ2YdiYhVYWRGo1YyFVSMrEwCD87u1EyKn5biaerGfmciMuUxL175/Ky2vxlQWP/KsSAc5tnF13b7Nam6JzkpHa6ROvoISihOVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187491; c=relaxed/simple;
	bh=IY7+Z0i2Be5asCD3wn3/WVykzXPNUe5Ku52bepTv9gA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=G44xzzR88eAnKFveFsx2pSMRbXw5ls2cNaVJGcTMzrkQv3s64o3zO1Lutd3fkvOGy4VnOv93MVuXovHnc6a3H87x/ct3Qj5fw7rrMQBQl9oiOM50uRhOLkVJtiUW+zq0GJyzxVcItmZoKoj5KaGNJ4N7fWYe3YcCVLPC9OG1+wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQbi0wrE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQbi0wrE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A4D1F000E9;
	Mon, 27 Jul 2026 21:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785187489;
	bh=mTrFJCB63Yie9+MTDG1MfrfCIbMGPkpG5TeQJqHKQBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nQbi0wrEPY8C6CVx+zf9VUfKY7ukDc8q9DtnonGNyNRc+BnUeFQ+n52vfntk4/rkP
	 mbA5BDrjRSYqyRzjzJqDpEVZZbbsU61NMdnQJgi4cChkRyUda2dBhTZevy3ePfB2Di
	 HUlPKG7t57Bmoll9QR24oXZ67kWhKG9EB1WLukxooaGInoVBbhQ6rEm0SeT1GgUjRb
	 2lb+bu1Tu8YrKZowOgC0SpCZDK0n608rPgo3f6d5PbSUuar2Tk4RMujf2kAGUFjQqa
	 IljwMRMC9KgAL4/hUP+YXtS1oPupr/ib2Ov6rFA4rQRmZ5vFOlHwVnkgeXz6gTIRBc
	 +AHNNfEv+T2tw==
Date: Mon, 27 Jul 2026 11:24:48 -1000
Message-ID: <952f200652a9a7e89ac2eb0364ed74f6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3] sched_ext: NMI-safe exit handling
In-Reply-To: <20260725005019.1297049-1-tj@kernel.org>
References: <20260725005019.1297049-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Fri, Jul 24, 2026 at 02:50:14PM -1000, Tejun Heo wrote:
>  0001-sched_ext-Make-exit-claiming-lock-free.patch
>  0002-sched_ext-Format-bstr-exit-messages-after-claiming-t.patch
>  0003-sched_ext-Report-NMI-kicks-with-scx_error.patch
>  0004-sched_ext-Abort-directly-from-the-hardlockup-handler.patch
>  0005-sched_ext-Report-scx_link_sched-failures-inline.patch

Applied 1-5 (1 in its v2 form) to sched_ext/for-7.3 with Andrea's
Reviewed-by added.

Thanks.

--
tejun
