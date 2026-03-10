Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECB1237713;
	Tue, 10 Mar 2026 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773105534; cv=none; b=iN+vKKarAohkYMnMHrCHYjxUETd45s7vm75BaXPJxCphNkFWCiKdeR6oW5q3czk4aYz6gC/cg5gKcy5axdCf59Xy2th1UcHQjusylp+oannDTNlORM8++wy0n4LfbalyF2fODL0GevIR5WmF38aQrhwOmHx3mz1hVjlz1ySI3tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773105534; c=relaxed/simple;
	bh=SQ4/fjfjflp1EUPnzqjAlgVLW9wEvvMMflNH0Xb3gn4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=MqfIDGVlx9xlBXQQmtI/lihLxkCrIs5a5fd89PN8pMhX7HVRmBDndL9A+DCqeM0/y1triDk2PiGV4kZt9/vGi5ZT+Srdd/77qThbv7zXy+wP/MxQF2awC04wCe3LukmjWgVQ2HDEAiOMb72IFUDE3aU0JIUMEweLbf6StJJMqxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LO3EZgPC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LO3EZgPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC28FC4CEF7;
	Tue, 10 Mar 2026 01:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773105533;
	bh=SQ4/fjfjflp1EUPnzqjAlgVLW9wEvvMMflNH0Xb3gn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LO3EZgPCmX/HdbwZVHI4VX25KMxFPyiKuVfXrWQ5Fv0arUqtoMvVdkMA+3+CUZnR1
	 HlvTZQL9gdxv3xVmRPetz0DsMjuiGgdkoxxpnz+XmZrBHlbyDl3zENo+nVWN2VYkxJ
	 /xxwo88GqbQ8COCgflkhbfdOuZ5YCisCdT4pNuTBetK+OBg9KRhtl3NA+qozvAFnIT
	 QyfjtGV17oJWSgr5Mcng69bs5jqrXKfEVZtMosLot49V1zis0rYJlOzrNMpmfvRbgL
	 hdSpPnP3fdsSq1rqE2L4XnJ1qFCcFSud0GhDm7YNPKJNbDAIn80orGPWaEspm7BL53
	 oAUohbpbtKraA==
Date: Mon, 09 Mar 2026 15:18:52 -1000
Message-ID: <c51b3df520276d1b5388e3334fa307bb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 jserv@ccns.ncku.edu.tw,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/1] sched_ext: Fix deadlock in scx_claim_exit()
 by deferring descendant propagation
In-Reply-To: <20260309163025.2240221-1-yphbchou0911@gmail.com>
References: <20260309163025.2240221-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Thanks for the report. I posted a fix series which takes a different approach
as deferring descendant propagation breaks the forward progress guarantee:

  http://lkml.kernel.org/r/20260310011653.2993712-1-tj@kernel.org

Thanks.

--
tejun
