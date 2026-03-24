Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3576C34C808;
	Tue, 24 Mar 2026 20:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384641; cv=none; b=ayUlxvgRrFjh0WgkREVjphrqJo/qodNq6aKlljx5BwGh9KCCfvC3/3ini2YCc0gLMawn8bz+FgJrfr1HgzHw0lO+g2L918CiYVlF9nLSHL/PZyVwlKXigr9JvG2eby/WfaJLL4sM8Xj4hce3TqYPPrvqsx8gcTm/sR1b4cYx2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384641; c=relaxed/simple;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=lIRVkGBqPBHKqvHnq8vdts+Dz6VNw17nDPrfj1M5Dig0tOBKYuNmCsElRbm4bGiiLGb8hNhy3iG751aBcl2h82N28FaRlBar34Ivel6Y3EGTUdA46uMJXS5gJnrQVE4+ESGKNUt3RDsSKTY1owHM5wPR3QcTiwjD/WnxTU8TLUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dywDqeC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dywDqeC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FF4C19424;
	Tue, 24 Mar 2026 20:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774384640;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dywDqeC5mLRuQRhGpsVSa2Bf+1gnC6mwdmjD/RP7iCa7gB2sWudYYswCH1o/AOHH7
	 HnC9qV8v6VRl7hwzTZJHmt44a7cCo233H/olLukfv7iEbHzD8qrA2NjR1uU8Msm5Xn
	 B83nNa5mr41r+Lg9ELbOGSr2WH9sPMlTLYiERih7F0eoUKA8rRo7GoPoKTK8DnEQGG
	 WUGvqBSHY/FKZ1/OOOVw1RbST3vmQdTf31hd5k8Taj6qushajQoyyDbNMMSJAhtQLA
	 j3H+M883UCVxdJTGyBsjI5RtoFT2VCL7e4NScFwhlWGD+4fM0dw6sHPnScBXyErTCO
	 AIDWuffpZjA0w==
Date: Tue, 24 Mar 2026 10:37:19 -1000
Message-ID: <0cda388856399d7d52513dce216d4bab@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 sched-ext@lists.linux.dev
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/sched_ext: Skip rt_stall on older kernels
 and list skipped tests
In-Reply-To: <20260324191433.1955484-1-yphbchou0911@gmail.com>
References: <20260324191433.1955484-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

-- 
tejun
