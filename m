Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774CF72623;
	Tue, 28 Apr 2026 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335903; cv=none; b=YDBiq/a5OOsO2W+zm8LEZp2lF8Yst8R7K2jb9AnJuxQi+9piP2MAjQm23PWsnajZdaWGFRTmBZHkFN2INlahwdCr38eaxFwQH5U5/i2tsR/q11BbHeFqj2KLSCya2Y5687yxWHuFpwbC6Ig6ShluSMhmd+WJMzuBrPALtZbnKgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335903; c=relaxed/simple;
	bh=UYBCCH7OIG2sDd3p1Z9c4kCSQA+Tvnc+8by39V28ezA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZiDoKDneQ6lY0YSrf/RF1Yx0aqWHt7NjVshTL3rlx/VgtJT4wad+zxmACcxx0vbPNHocCvaJk7mJ5POQHJxhWOJPflLEt+jXt67IqrZxfNaKTNncQdb9V4+WVmLAqVK3qVbV6gxCaTw3NTKgCRyTIaukrdbhGvN/iLMenMWhFN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd8dUvzS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd8dUvzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D14C19425;
	Tue, 28 Apr 2026 00:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777335903;
	bh=UYBCCH7OIG2sDd3p1Z9c4kCSQA+Tvnc+8by39V28ezA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vd8dUvzS3Og8XDfA9I07l/92ysinjuC7ILfkRnkYySR5QRH1xClCfb0p6Zf/GYw89
	 Gs8cPGfRhAhCfqe2lzdVINPtr9F87HarI7DAKQUWVi2W+9BWUbC3sXavZ2sdfZEDLa
	 +/fFHSrqi1E9SH0a2o/bPNQm2fuwiLoQBdskWIRHKG41v127Bufpc1Le0SCf1u6PCW
	 hG3f8oQVvhXj2fSbtGckjKIVaZI4MjkVKIrdJ+17qF1FSiJjDhc+o8FlAj2H0xBFxD
	 OV8R53AHs4P7kkhqVSkTpA5ly7cvDJOYxLdGBEBP95tYzmK7S9xPH8rbPFslCdfeYV
	 WcbWPK3BV4WrA==
Date: Mon, 27 Apr 2026 14:25:02 -1000
Message-ID: <87a206508f68d54b6e36eb153f1f591f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.1-fixes] sched_ext: Use global task iter in scx_sub_enable_workfn() abort
In-Reply-To: <20260425023724.1249914-1-yphbchou0911@gmail.com>
References: <20260425023724.1249914-1-yphbchou0911@gmail.com>
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello,

The bug you reported is real but the proposed fix isn't quite right -
switching to global iteration in the abort path closes one window but
leaves scx_sub_disable() and scx_fail_parent() exposed to the same
iter-vs-sched_ext_dead() race in different forms, and the prep loop in
scx_sub_enable_workfn() also has problems with tasks past
sched_ext_dead().

I've posted a two-patch series that addresses the underlying issue at
the iter level:

  https://lore.kernel.org/lkml/20260428001635.3293997-1-tj@kernel.org/

Thanks for the report.

--
tejun
