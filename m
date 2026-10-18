Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CBB2D662F;
	Sun, 18 Oct 2026 08:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792311361; cv=none; b=kLen7RwS/blD0i1GfUJlZv240uN94mbMdFay8pem+pORwSYtais9exbQWGOOkEMnl5p6pGMPLXBlx6W2oD0vJgIWursK4U5dt0kM47WsdB7OskXJt5A/FEOLl3/DIrjRd/3bga5czRsFk26Ky7vvvON/LwEVURgvTZ3lwaFVsz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792311361; c=relaxed/simple;
	bh=0sMfeGjpcNgoa89yE1kqEvGQiGlCfKyANC4Ddzf7BA4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=ofLC4xXjE/s0izqk/XtGbp1bccNVtb//0adoSKlwDrot+XFlhwDmhAFaajh1aNXPuD1TOKHfvhzJnlSvFEDHTtCsx9d12g3F3vpeuyQucrXeV62/C4gozgpQ4notSGDmURE5b1PTgbUN+GTKeGjpv9mnaAJ2aA0USGKgLTJmr9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/6TFC/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/6TFC/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 246C61F000C4;
	Sun, 18 Oct 2026 08:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792311360;
	bh=0sMfeGjpcNgoa89yE1kqEvGQiGlCfKyANC4Ddzf7BA4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=U/6TFC/JHpCGxm6/HAweHjjbHkub1tC2dZS7d0nmo8sVWJ7I98UuIT+boilptt3Bd
	 TrqV8208G2FxmDPUJOZn9d9HiP1trl5l5NFI1vPMoPQ3rUJEQupNFsoRtC26LDGpxH
	 o78zE05qZKsj/mqB6hl8Gl8bbla/hhmGzUnVR80LSvcZw183QkciUaDomlX1I5T8wp
	 pCQDcKEVYX5Gndt7qnulSAg+2raYg+1jOEIeEorJeCMFaxLHlDgS1AFg46RujatuW6
	 CpyzkH2wdaUeE2h2SC1Ky3rt29VFP9ZTU8vE39Lw7zBSoD83FXoEoeGFTh+l+ywC6e
	 L79SmugBbiytg==
Date: Sat, 17 Oct 2026 22:15:59 -1000
Message-ID: <af30f322c7303a7280580eede1e0bd97@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: sched-ext@lists.linux.dev, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] sched_ext: Report the ecaps loss when a cpu goes
 offline
In-Reply-To: <atRsDV9T_lJpgWs-@gpd4>
References: <20261018015952.1499528-1-tj@kernel.org>
 <20261018015952.1499528-6-tj@kernel.org>
 <atRsDV9T_lJpgWs-@gpd4>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello, Andrea.

On Sun, Oct 18, 2026 at 08:49:49AM +0200, Andrea Righi wrote:
> nit: nr_ecaps_offline lands between two 8-byte aligned fields, which adds
> a 4-byte hole and shifts everything after it (kick_sync included) by 8
> bytes. Can we move it next to kick_sync_pending instead? Something like:

Will do.

Thanks.

--
tejun
