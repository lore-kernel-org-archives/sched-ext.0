Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50814340A72;
	Wed, 12 Nov 2025 16:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762966145; cv=none; b=ZoERd1mmNNgA5CxxyLJvSeoHSMsRtf16owRjWcHz6cmI8b4czCeUbrjI89VaEQyr/c0/v1YIgLnCuKkVOEchrvcWJqkA4sCVhU+dXy5p96Wz0I60Xky8IiSLMb0J1si4eReP1o7Den52D5fl7d1AYjN1ZtMpJ6pBPOUlgq2lUj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762966145; c=relaxed/simple;
	bh=atxDHl3mLVj9+A0+lk008KmAAvyRFjEwM50m3XplaY0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=gAEbb7PjGrQ6HbQPZyBlx8aT5PDMRbAYI85eX6trW+G+rSp2NVB/DdqJwKc0tiiBAm214kWMtacVX6oX/PcNdSCTilUNGNsFLHQG0aFDE8mVCSrCGopHBpqwDjcEm0EjHmkYScwhOgGPVNV9QVd5haiwhwMKF3SFp0mKQXbMlwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O67Qb57Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O67Qb57Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9F9C4CEF8;
	Wed, 12 Nov 2025 16:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762966143;
	bh=atxDHl3mLVj9+A0+lk008KmAAvyRFjEwM50m3XplaY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O67Qb57Qr6a+wNhZL/2jEOKnSh90aOFZMrerzIBbJ5ub7+1V3ue8bpxExjVJVH4By
	 jwUvOKDNDQUkvxbwPvc7lNRkp+f4egf2jo6YymjOVPONETSRrL93f8duOqoaSPH5Ec
	 xAaJeDOngK0pNNXIKiLSG6rG7yWEobmjwWHo39U3ukhpHKy0dSl/MFBfj3UA3s/oK3
	 DLUzftcWX4FMVyeed+zgatl459kOcMnGXwuIMG59Qqqr2f0mWVjH6wjy+W9JrcoAAj
	 7laci9gd0Q0L5OWME9Du6iNMmE+UXZ0cxYUSM0k7ew9UKpohsj920raa+huF1mxyF5
	 9grG+wUedJVVQ==
Date: Wed, 12 Nov 2025 06:49:02 -1000
Message-ID: <ef6ab4cf9bbe1865c6d7d2fb0fe9c3d6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <andrea.righi@linux.dev>, Changwoo Min <changwoo@igalia.com>
Cc: Dan Schatzberg <schatzberg.dan@gmail.com>, Emil Tsalapatis <etsal@meta.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-6.19] sched_ext: Improve bypass mode scalability
In-Reply-To: <20251111191816.862797-1-tj@kernel.org>
References: <20251111191816.862797-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 1-13 to sched_ext/for-6.19.

Thanks.

--
tejun
