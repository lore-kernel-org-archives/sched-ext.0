Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520523;
	b=JVMJC9yBaw9M/w0K10uXqVJ/yz6ZIttDXohqaFsmkvJmOocRxfd0DvTl503O6mqPBoC/
	 xch1yB0maHkPRj9UcETH0fEv2Y4Rw2BU6jqVIjJ5NewII/DxLIVzCicdnSWtUj4U5JWTu
	 6fbnDwuTs30LjrRV/eZVZsb1I1tgCn8ykjgUW1Lp+hCNtVS/+Ktw76aU3rqnUXYfKqXzI
	 jp5jbxOBklr0qOVsuSqiUhMaxEm4dJ6x9d8T41PSnBguz5sA0hEt5IJnMGyhSngC3WEIY
	 oE4YsqmfjmVE6VrP5Unc1WlBoB0/+Nf52Kb8O5lfZn7CbJ0nEIzCOUgPciWubHmAtiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520523;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	b=Wd9BpEnJ3i4Bdm2KhSEXIxhcBQsUO0m6+FK8BNuqAz0UuCZFlecSecm9hTPkoSCGpCwx
	 +SxhK1+XvNConRGoNezL0LuxWJZyGboMdaM2TnHQRf4wJcaREiKAhICnQXpcF5o/8PQEp
	 fUeO/r1q7/ZAgBstwFf0IBV+lycQ6VQ0+qECepRPuzGEXRkHjf9cfUVHk3MOg6X7crn6b
	 amxKeHAuX3eWofQEgYRNrTo1TmQc2jubngAjk+0NGGeg2YzedrfhVrjMZ7Std8Gvuje1l
	 1ceAJzXOxdnPTxa5TuuEM1BRLNseym3KFOaWuL7ggA8ofdfW7JddIFNgZv5rexU9zqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sog+WkCk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C729606A319;
	Tue, 20 Oct 2026 18:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sog+WkCk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E0AB1F000C9;
	Tue, 20 Oct 2026 18:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792520522;
	bh=60a0/HLjQTWhu7YxyY2UEEVoE9Eqcv8bbTKkNoYxrVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Sog+WkCkOElzJIX4XVceOM/TY8SvtuNP2JIJCyUnao/31V0DNGKNAx1SVtejAJgpt
	 giO4Ya0DDiah9C37M3CzhaxtrDieLBjTHV1nfCc+reKZp91PhANfkg41jTzau9Orz2
	 WigB7SW14r/nMPrqUYV5Cd9mg3PMIa1E7JBSuIwFGds4sDIoYPlj1dr6ci9fUwYVhr
	 6wuwj2pjSjlTEtPvFtC78NFvtzfRoaunwRA9G4D2qQZVhZSXJEIVQedKfOF26P5oXw
	 ZMuSOj5I6lzt+SvUszm3yx7q6MscEPXdrZdtX/LFGWHN1qtr2FPw4faxr7MxVSoTOx
	 3Ovqp3V1KKigQ==
Date: Tue, 20 Oct 2026 08:22:01 -1000
Message-ID: <3438e7928ab1bda677019ee77f40e3dc@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Michal Blaszczyk <michalblk@google.com>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Kuba Piecuch <jpiecuch@google.com>,
	sched-ext@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/sched_ext: Add class_switch_stall test
In-Reply-To: <20261020075029.330343-1-michalblk@google.com>
References: <20261020075029.330343-1-michalblk@google.com>
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list

Applied to sched_ext/for-7.5.

Thanks.

--
tejun
