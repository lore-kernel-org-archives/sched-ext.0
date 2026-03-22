Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B83836683B;
	Sun, 22 Mar 2026 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774209992; cv=none; b=t4IgK0asiZ1pnzWs0VSzI4hE4/N8y3fKx6MT+WCnI0p3jfvcI7SgfPPvYGDtVUBrR1t7T9IKNADSQarwsmV7ySnTXxbyDywquiQXuzeKUHam5U410x0Ym+jZa04zLO95UsuxP0JTiTutACunHkwdAtp+U5WmswMDFqChRvAsy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774209992; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=cPO2NZkeQdiH16s4IS6kmVc2v9nurtX0XsUu3SCs0MNOSX16c2hkbpkGN6t3SzYwJNUD/h6eFr+hzof6pWycfASKGonkFl5T2DFz3/1uNJTKWu8D3VmTNsK2ouWuA5JThpFjzgdkt7x6+piczWEd3F/Dz3DAure5IxpYSghgLug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BdVBc2IZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BdVBc2IZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3BC7C19424;
	Sun, 22 Mar 2026 20:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774209992;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BdVBc2IZ4cWcYxnYEKByI+DMuJPmMiGNIFCtr8ho6K88XmgCvnh+HkCiGpqvgqxYZ
	 zuEsbmeEtwwwC8MARvr8KJ1v08O284a6ffZ5NqhbrQ66U46J3U+cEcmcfTfOn8jJTo
	 aTiheUtCPkWnWkc2Axp0m7OEHYh1gcqvQRpthdUydw43YwD4to9yX+SEjfgij0hGMO
	 rYXWbqL4vj255TTK/in578V87ynRDYBjgA/HR8r6Km7aCG/U3wMfh51kc/u5M8By2g
	 zF0KK5V9EmvGwBzyrkmmj43B4CnWN7O03z4IxJ8kAR9LikvyM83X0FBh8JCpKiOG9N
	 GD/uO3Uebt1WQ==
Date: Sun, 22 Mar 2026 10:06:31 -1000
Message-ID: <cae338e4c767534da1ceb172162d1bda@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
 sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 sched_ext/for-7.1] tools/sched_ext: Add compat
 handling for sub-scheduler ops
In-Reply-To: <20260322063546.304416-1-arighi@nvidia.com>
References: <20260322063546.304416-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
