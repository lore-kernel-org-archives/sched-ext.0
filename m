Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC32DDAB;
	Thu, 26 Mar 2026 00:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774483372; cv=none; b=Ld9Mc1CCwo8SzWikLqvhbJSk+ViG2HyYx7FeOLmyiyUZuQkuanODqZStD+096ugEDe8AVBDxxAtVNnWt+H8ZLjvit/dCi++UDIglArWGwUu5pvQOIC3jZRepdObIa3d+2GPUl+9wsmhuOPBh1AbnI8U5gIQSn1+Q7ImIykv+k4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774483372; c=relaxed/simple;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=pwl8CDzs30GUVqNzdBuc8iBmZlNfCpyEhLU62gU/+k8qc7J3dHxoUqHgEEsdjnUBndukupzRCXiGfu2ymS3CqslqYV5r1FwYUUd8ACu/kDZofknIVa2SAXy+qA/d8/ptXbgejg8Ru6K6Zczfeafu6pXzU73kc5Lxj9GB/LMvc/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lv2luwGQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lv2luwGQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EF71C4CEF7;
	Thu, 26 Mar 2026 00:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774483371;
	bh=/6Uj9XwUoAPU0BcQZVOTdOUSFBimlsKmIkp3D+XTOGA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lv2luwGQGktgRryRYvuuPD8iW9UdgfbB+SX7Y3lfXXOeH0GGZUx379eFFrM4ahXO2
	 iuosMNXzGTHjtOgUIZm8sqVL/O/tNaob0A/ZllWGqoLLUl+39O5UJKG9QDK+o5W1fB
	 Fp8A6sIZBxZMe5ED8/2YY4Xaxfz7YqbekTdokoXZtAqUuARoY2CV+k/0VM5jUYNfBN
	 Qk0xbjWyU0h4jbsbHUZ+J7WJ1GenZQpqR+FJe8vGmwWZDtBO8BCyZdz7veF/g2IcAz
	 qz/CxiUmKFd+qpkph/nW8N7t0yVQBjIgmlnLKW7L9SXYtco0J3q7KD66QHgi3adfWL
	 dsYZrDB9MGf3A==
Date: Wed, 25 Mar 2026 14:02:50 -1000
Message-ID: <3f41f6dfd9f2cb524a4c6bc4b348dd6b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
 sched-ext@lists.linux.dev
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Documentation: Clarify ops.dispatch()
 role in task lifecycle
In-Reply-To: <20260325212100.511928-1-arighi@nvidia.com>
References: <20260325212100.511928-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

-- 
tejun
