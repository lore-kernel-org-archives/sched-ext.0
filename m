Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9856309F19;
	Thu,  2 Apr 2026 19:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775157834; cv=none; b=fwyqAMPpK7Ckog6/PaGv5S6XzjNztPmgCv3rp7DX/IA/hUUr2CkgZfq+W0Lc+YBSIHpKTjzYODO+HPDEQDEYGQSvkWgXwj9IUHVgkKiH9HKInrnQfIFT+uN3Zsb9xANtuyZtjkq1ZOReVooPRvuPLwYV7ReW+6qzpPqTxgkvEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775157834; c=relaxed/simple;
	bh=vqx/MZHF8f9il0rGOTsDE3ph7fezWDjioB1ephUzl64=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=qWokwKWxIvaieXKnJ6MMUftHcC9LX8fZMuyHEoEemJwdlr/Ibnj2T80ACeyVw+DaJZXCllnuegnrvgOk4PV7EY+4NTVE1Gmzi2vrNzR4WeQ8nG7fxyrJvWv0lhHOJG4WwaLHwFiOyX8shGwcKS3fjk9aQC56Qw6YsVyPvxkrSxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ChJAeUVi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ChJAeUVi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62021C2BCAF;
	Thu,  2 Apr 2026 19:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775157834;
	bh=vqx/MZHF8f9il0rGOTsDE3ph7fezWDjioB1ephUzl64=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ChJAeUViq36xGScFJlgVTOvJ+WgMNtmgcaTchz4iuojRcfbWU8sC81EXHtUzCyXVN
	 1MtDiUz9AU2Vu6m9Z1vYcR2I2w31QgG5pIl3y2QkV6tAg48iI/YIguldx5OvPR1b6P
	 ofyIwzXQ8ahpwNnNCTCzcYO1Sz4/jC4vwiVBR2oNv8r6XT/tEy4Z0S3v8hsmguW1aC
	 g7hMAzWEHtiGI5abEGGncIeZVDErY5Q6tpcOfCM8e0KJ1+5USWxLiHxozfTF+vnJ3i
	 SrTAweuOPEhFnHAB3aSqYVjZbC0Sf1rFEKL8lTuQoCeTa/mZFUvyRCPXm7mZJbV3fP
	 XqpPINI49oP5w==
Date: Thu, 02 Apr 2026 09:23:53 -1000
Message-ID: <393da1e19829508f97fba3d10ad9503f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Samuele Mariotti <smariotti@disroot.org>,
 arighi@nvidia.com, void@manifault.com, changwoo@igalia.com
Cc: sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org,
 Paolo Valente <paolo.valente@unimore.it>
Subject: Re: [PATCH BUGFIX] sched_ext: Fix missing warning in
 scx_set_task_state() default case
In-Reply-To: <20260402170025.1387202-1-smariotti@disroot.org>
References: <20260402170025.1387202-1-smariotti@disroot.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1.

One note for future submissions - there's no need to resend the same patch
multiple times in quick succession.

Thanks.

--
tejun
