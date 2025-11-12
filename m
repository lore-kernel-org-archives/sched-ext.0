Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77E4328636;
	Wed, 12 Nov 2025 16:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965242; cv=none; b=rQ6Z2tsYg5ib8jLqMkEaoHV7hNcOVOPdaDyAR0NMaYEtee53rW7X2X9AtdiHJKfY05IMwZupcbONw0LCcIVuJ/+As/cZ5bq5XGqSQtFs9kN8lycDr8lhHJZPTPakfH614s4zwIKjbx8EoW43cVg6XtASafoUBwjAGu36d+Qn1cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965242; c=relaxed/simple;
	bh=NBplsh0624Kjxvu8SMTCt/4O0tSu1lpyz5XBuZRcxiM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gVrOVW3OQ5tNF/4ouPXo2sqwOnlFuECRWvrn6M9K21R/BRzbCDhR6xGSK5CKDpGrXezPQfVJZu4X/tZx0DDT+gd3g7ljRIg2T2ZBp1YLjVY+Ho3D/akBSCOxmoE/ftdBuD0d/URFsfv2EhpGV3Doycc0U2K3O4UMdQtEqkNbHk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vtp6zaFf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vtp6zaFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A83EC4CEF5;
	Wed, 12 Nov 2025 16:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762965242;
	bh=NBplsh0624Kjxvu8SMTCt/4O0tSu1lpyz5XBuZRcxiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Vtp6zaFfCG/8wB2rosTWXKsC2EFAYkz4cAPI2WIDgpyZoBNUXagfqCV2d/sOnAxw2
	 NBmeijGWaRZxgMBNLUfSRXWx6Z3Z39NSnlnLorcSH3hsOyRKTPOBDwSMtMddTWrd4I
	 6vo24/SSCJVs51afVeDEe8BdK9BNPEOir/204uyYDKhP2KkxYe7zwkng+euxFj18w7
	 D6QXJDelULvzK+eLkYAkEvwbm2bYjP2TwJLdP1ergtQSwdoitaBHCIE7Lu+FGauGg4
	 TW1uRfWP8h8oCB8Rrr2JXonc1g/a8WuCDtDMQvplQ8YPDDIknMvI4YcbNUVa+kRm/w
	 GUaRXn/iGGPkA==
Date: Wed, 12 Nov 2025 06:34:01 -1000
Message-ID: <74da46d928cb25b9e0a892f20e0323c3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Zqiang <qiang.zhang@linux.dev>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix unsafe locking in the scx_dump_state()
In-Reply-To: <20251112073328.14303-1-qiang.zhang@linux.dev>
References: <20251112073328.14303-1-qiang.zhang@linux.dev>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-6.18-fixes.

Thanks.
--
tejun
