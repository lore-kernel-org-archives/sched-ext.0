Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D7957ED82;
	Tue,  8 Sep 2026 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890692; cv=none; b=b4iaMOh/UG2KdxFS3Pn7u6kKc/Oog4RrVnK38r4yl21L4WiErVecEUqENnZO/uMaVO/+pxMokklrW+jAIgswKx0/XGLUuPJhihFiJAn4atBN/36mJKO3YSi5JSXJzB8Xpie/sBBcLv5ARdxjESteE95p6cZm6+qk08VrT4gq7WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890692; c=relaxed/simple;
	bh=+izvuhEto/rqxeDKdYSqynpvH9Sk7+k/IJJ1b6pN4dc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=chW6R33pV7JO7BywkVmuXFb8R26pQie7gOqtCNVYX3JTOqEiSTbCNkq3s82TSosGlGPCyWmfU+7vo8isqc6469Fal/s0Vd8brZ38HbyHkPzei8qKzX/hoW+s0qD+D+9TWI3ulGuaP6Fhdk5Knu3tqNF2ZMycICUDAWIEnx+EotY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ED2VC9yo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ED2VC9yo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 764701F00A3A;
	Tue,  8 Sep 2026 18:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890690;
	bh=yrCpXGcoydJmpbJVtpIANkua0JB5sKTWmN4rMBY1Ylk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ED2VC9yoT3uyz35ZSFmzvsIgfeYFCQxPVPP2W9EtuabaZXFPBkk4qpFZv35vQ1eRz
	 M9qnPF9yAobUc7XqOvae02fSfb7pXpuFXN58j+bl2xOI7/CpJh5Vdl+3ckZZFc2KzO
	 RUyY9gEUSF3H8AU5Vlp9SvqrgKl5JAW6thXlBgzZHhbepvAjdakF5E5UpOUv4qSSMr
	 K7jJCIo4iRh7qjTUlTBa3kgdD9TLW6eypyifOFKjC7YqXrrULCqAuAqn6yvGhH27bj
	 q9Oiza49/0zH8lfzve0GIS93rtpBzmu45iswn9XyjBSmMIRDSxCD0hZlBPQzlR4T9J
	 V3ZNro98RKx6A==
Message-ID: <1a60af2608a5d068d55ad5022d8221f4@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tianyi Chen <hi@tychen.cc>
Cc: Tejun Heo <tj@kernel.org>, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] selftests/sched_ext: Fail interrupted test runs
Date: Tue, 08 Sep 2026 08:01:34 -1000
In-Reply-To: <20260906135507.749280-1-hi@tychen.cc>
References: <20260906135507.749280-1-hi@tychen.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello, Tianyi.

Applied to sched_ext/for-7.4.

Thanks.
-- 
tejun
