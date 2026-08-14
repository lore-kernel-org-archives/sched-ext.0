Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769E233936B;
	Fri, 14 Aug 2026 18:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786732419; cv=none; b=ayj/TxmVvlY6q2OMLXAYHWx8xOrXW2QXLe72mQpZKEaUmNQ3KdSTefnW12EgLAepHwSBfB9LYTTXJIsMQmqJ67dHZR+AAng94wHxKnifq7hDMHzYeq96tpr+4G+cTSNF6NsAzPaGzlnhBLwuy4ckT3gJk0BOUmyY3fPngmkexeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786732419; c=relaxed/simple;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=G5O4BxnkP2FQpCZLkow1/rGNLbEgwTVeHw3QkafLGqDOtmxEQHA+ihJJep6Va1LyH9RnjOTX/LSiSD4paC7l4t8NFJ0GvhHWDvH6FcX2+nS1DodCHnEbkgxToadPNuW2OD+pV8RzXllvLVqrstBCLnVSzGY2iAoMBb224IA5RNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NndpvNFN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NndpvNFN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2229C1F000E9;
	Fri, 14 Aug 2026 18:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786732418;
	bh=286DKP7EYWnggjEkXb9NUKoDBTmGKiRd8QyJHJItIKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NndpvNFNNn/WuOmSRMPuFVdUWEHIdWwfM3UZ5rusCxsNVxW/vM+1OssZ3CmzLCNy+
	 XKNj07DbcCofOFOdwxGYcICQQ6nl6r1wdEi4yja6wfIBQ2b2wiY7nCq/5TeMfWZ/K9
	 bA+zUIxh1/xJ7dw0HO+/raN8/9SfaajUkEbYqiJwmZqZtqmp9f5llWTtVICXLNjTXF
	 2l7nqJtXlR1+FbUaUu+gB1qSsbqjakA8B3h6OhzaIl6srnAPeDya5BWiBsi/AvdkZf
	 4IB4Euspz9/gXPlWydbT2BFPNliC2kAYYjXh1hwDWjVPWtjNLC1EcuT1Ck/MkxdNuc
	 PsAKhCYGm0zEQ==
Date: Fri, 14 Aug 2026 08:33:37 -1000
Message-ID: <fde1362617a59cca6b66105704cc1b9f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: David Carlier <devnexen@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3] sched_ext: Set up
 ops.sub_ecaps_updated() dispatch context on the executing CPU
In-Reply-To: <874500f5212b5d192092950ea8d284b8@kernel.org>
References: <874500f5212b5d192092950ea8d284b8@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.

--
tejun
